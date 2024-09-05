import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/Trading_chart.dart';

bool button = false;

class LiveChart extends StatefulWidget {
  final Map<String, dynamic> stock;
  final Function(Map<String, dynamic>, bool) onToggleWatchlist;
  final Map<String, dynamic> timeFrames;

  // Callback for updating the watchlist

  LiveChart({
    super.key,
    required this.stock,
    required this.onToggleWatchlist,
    required this.timeFrames,
    required bool isMini,
  });

  @override
  State<LiveChart> createState() => _LiveChartState();
}

class _LiveChartState extends State<LiveChart> {
  Map<String, dynamic>? historicalData;
  String selectedTimeFrame = '1d'; // Default time frame

  @override
  void initState() {
    super.initState();
    loadJsonData();

    // Fetch the initial state of the button (whether the stock is in the watchlist)

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> watchlist = prefs.getStringList('watchlist') ?? [];
      setState(() {
        button = watchlist.any((item) {
          final stockMap = json.decode(item);
          return stockMap['symbol'] == widget.stock['symbol'];
        });
      });
    });
  }

  Future<void> loadJsonData() async {
    // Load stock data from local assets (mocked data for now)
    final String response =
        await rootBundle.loadString('assets/historical_stock_data.json');
    final data = await json.decode(response);
    setState(() {
      historicalData = data;
    });
  }

  Future<void> toggleWatchlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> watchlist = prefs.getStringList('watchlist') ?? [];
    Map<String, dynamic> stockData = widget.stock;

    if (button) {
      // Remove the stock from the watchlist
      watchlist.removeWhere((item) {
        final stockMap = json.decode(item);
        return stockMap['symbol'] == stockData['symbol'];
      });

      // Remove the corresponding historical data
      await prefs.remove('historicalData_${stockData['symbol']}');
    } else {
      // Add the stock to the watchlist (if there's room)
      if (watchlist.length < 2) {
        watchlist.add(json.encode(stockData));

        // Store historical data
        await prefs.setString('historicalData_${stockData['symbol']}',
            json.encode(historicalData![stockData['symbol']]));
      } else {
        // If the watchlist is full, show a notification
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The list is full')),
        );
        return;
      }
    }

    // Update shared preferences and button state
    await prefs.setStringList('watchlist', watchlist);
    setState(() {
      button = !button;
    });
  }

  // Filter data based on the selected time frame
  List<Map<String, dynamic>> getFilteredData() {
    final data = historicalData![widget.stock['symbol']]['time_frames']
        [selectedTimeFrame] as List<dynamic>;

    // Limit the data to the last 100 points for better performance
    return data.cast<Map<String, dynamic>>().take(100).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (historicalData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final data = getFilteredData();
    if (data.isEmpty) {
      return const Center(child: Text('Insufficient data'));
    }

    double latestPrice = data.last['price'];
    double previousPrice =
        data.length > 1 ? data[data.length - 2]['price'] : latestPrice;
    double priceChange = latestPrice - previousPrice;
    double percentageChange = (priceChange / previousPrice) * 100;

    return Scaffold(
      backgroundColor: const Color(0xffEBFCF8),
      appBar: AppBar(
        title: Text(widget.stock['companyName']),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.stock['symbol'],
                  style: TextStyle(
                    color: const Color(0xFF191919),
                    fontWeight: FontWeight.w400,
                    fontSize: 22.sp,
                  ),
                ),
                GestureDetector(
                  onTap: toggleWatchlist,
                  child: button
                      ? const Icon(Icons.bookmark)
                      : const Icon(Icons.bookmark_border_outlined),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$ ${latestPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: const Color(0xFF191919),
                    fontWeight: FontWeight.w500,
                    fontSize: 22.sp,
                  ),
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.50.w,
                        color: const Color(0xFF4E4E4E),
                      ),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.stock['sector']),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '${priceChange >= 0 ? '+' : ''}${priceChange.toStringAsFixed(2)}',
                  style: TextStyle(
                    color:
                        priceChange >= 0 ? const Color(0xFF04F565) : Colors.red,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  ' (${percentageChange.toStringAsFixed(2)}%)',
                  style: TextStyle(
                    color: percentageChange >= 0
                        ? const Color(0xFF04F565)
                        : Colors.red,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  selectedTimeFrame.toUpperCase(),
                  style: TextStyle(
                    color: Color(0xFF9A9A9A),
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              width: 380.w,
              height: 350.h,
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              decoration: ShapeDecoration(
                color: const Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1.w,
                    color: const Color(0x545454),
                  ),
                  borderRadius: BorderRadius.circular(1.r),
                ),
              ),
              child: SizedBox(
                width: 380.w,
                height: 350.h,
                child: TradingChart(
                  historicalData: data,
                  isMini: false,
                ), // Trading chart widget
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NSE',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16.sp,
                  ),
                ),
                Container(
                  height: 35.h,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.50.w,
                        color: const Color(0xFF4E4E4E),
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: TextButton(
                    style: const ButtonStyle(),
                    onPressed: () => setState(() => selectedTimeFrame = '1d'),
                    child: Text(
                      '1 D',
                      style: TextStyle(
                        color: const Color(0xFF191919),
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 35.h,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.50.w,
                        color: const Color(0xFF4E4E4E),
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () => setState(() => selectedTimeFrame = '1w'),
                    child: Text(
                      '1 W',
                      style: TextStyle(
                        color: const Color(0xFF191919),
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 35.h,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.50.w,
                        color: const Color(0xFF4E4E4E),
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () => setState(() => selectedTimeFrame = '1m'),
                    child: Text(
                      '1 M',
                      style: TextStyle(
                        color: Color(0xFF191919),
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50.w,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
