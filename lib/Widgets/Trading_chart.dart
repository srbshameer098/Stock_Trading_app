import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TradingChart extends StatelessWidget {
  final List<dynamic> historicalData;
  final bool isMini;

  const TradingChart({
    required this.historicalData,
    required this.isMini,
  });

  @override
  Widget build(BuildContext context) {
    if (historicalData.isEmpty) {
      return const Center(
        child: Text(
          'No data available',
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    print('Building TradingChart with historicalData: $historicalData'); // Debug output

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              getTitlesWidget: (value, _) {
                final date = historicalData[value.toInt()]['date'];
                return Text(
                  date.substring(6), // Show only MM-DD
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                );
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: false,
          border: Border.all(color: Colors.white, width: 1),
        ),
        lineBarsData: [
          LineChartBarData(preventCurveOverShooting: false,

            spots: historicalData.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value['price']);
            }).toList(),
            isCurved: true,
            color: Colors.teal,
            barWidth: 3,
            belowBarData: BarAreaData(show: false),
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
class TradingChart1 extends StatelessWidget {
  final List<dynamic> historicalData;
  final bool isMini;

  const TradingChart1({
    required this.historicalData,
    required this.isMini,
  });

  @override
  Widget build(BuildContext context) {
    if (historicalData.isEmpty) {
      return const Center(
        child: Text(
          'No data available',
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    print('Building TradingChart with historicalData: $historicalData'); // Debug output

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true), // Hide grid lines
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide bottom axis titles
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide left axis titles
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide right axis titles
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide top axis titles
          ),
        ),
        borderData: FlBorderData(
          show: false, // Hide borders
        ),
        lineBarsData: [
          LineChartBarData(
            isStepLineChart: false,
            spots: historicalData.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value['price']);
            }).toList(),
            isCurved: true,
            color: Colors.teal,
            barWidth: 3,
            belowBarData: BarAreaData(show: false),
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
