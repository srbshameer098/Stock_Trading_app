import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/Trading_chart.dart';
import 'Live_chart.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  List<Map<String, dynamic>> watchlist = [];

  @override
  void initState() {
    super.initState();
    loadWatchlist();
  }

  Future<void> loadWatchlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedWatchlist = prefs.getStringList('watchlist') ?? [];

    setState(() {
      watchlist = storedWatchlist
          .map((item) => json.decode(item))
          .cast<Map<String, dynamic>>()
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEBFCF8),
      appBar: AppBar(
        leadingWidth: 100.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w, top: 20.h),
          child: Text(
            'Watchlist',
            style: TextStyle(
              color: const Color(0xFF191919),
              fontSize: 18.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: watchlist.isEmpty
          ? const Center(
        child: Text('No stocks in your list.'),
      )
          : Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: ListView.builder(
          itemCount: watchlist.length,
          itemBuilder: (context, index) {
            final stock = watchlist[index];
            // Fetch historical data from SharedPreferences
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LiveChart(
                      stock: stock,
                      onToggleWatchlist: (updatedStock, isAdded) {
                        setState(() {
                          if (isAdded) {
                            watchlist.add(updatedStock);
                          } else {
                            watchlist.removeWhere(
                                    (s) => s['symbol'] == updatedStock['symbol']);
                          }
                        });
                      },
                      timeFrames: stock['timeFrames'],
                      isMini: false,
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.only(top: 10.h,bottom: 2.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stock['symbol'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(width: 10.w),
                    SizedBox(
                      width: 90.w,
                      height: 35.h,
                      child: TradingChart1(
                        historicalData: stock['timeFrames'] != null
                            ? stock['timeFrames'].values.first // Adjust based on the structure
                            : [],  // Provide default or empty data
                        isMini: true,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  '₹ ${stock['latestPrice'].toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: const Color(0xFF191919),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${stock['priceChange'] >= 0 ? '+' : ''}${stock['priceChange'].toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: stock['priceChange'] >= 0
                                            ? const Color(0xFF04F565)
                                            : Colors.red,
                                      ),
                                    ),
                                    Text(
                                      ' (${stock['percentageChange'].toStringAsFixed(2)}%)',
                                      style: TextStyle(
                                        color: stock['percentageChange'] >= 0
                                            ? const Color(0xFF04F565)
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
