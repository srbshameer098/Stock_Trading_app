import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Live_chart.dart';
class Stocklist extends StatefulWidget {
  const Stocklist({super.key});

  @override
  State<Stocklist> createState() => _StocklistState();
}

class _StocklistState extends State<Stocklist> {
  final TextEditingController _textController = TextEditingController();
  List<dynamic> stockList = [];
  List<dynamic> filteredStockList = [];
  List<dynamic> myList = []; // Add this to keep track of "My list"

  // @override
  // void initState() {
  //   super.initState();
  //   loadJsonData();
  //   _textController.addListener(_filterStocks);
  // }

  @override
  void dispose() {
    _textController.removeListener(_filterStocks);
    _textController.dispose();
    super.dispose();
  }

  Future<void> loadJsonData() async {
    final String response = await rootBundle.loadString('assets/historical_stock_data.json');
    final data = json.decode(response);

    setState(() {
      stockList = data.keys.map((key) {
        final stockData = data[key];

        return {
          'symbol': stockData['symbol'],
          'fav': stockData['fav'],
          'companyName': stockData['company_name'],
          'sector': stockData['sector'],
          'latestPrice': stockData['current_price'],
          'priceChange': stockData['price_change'],
          'percentageChange': stockData['percentage_change'],
          'timeFrames': stockData['time_frames'],  // Store the time frames data
        };
      }).toList();

      filteredStockList = stockList;
    });
  }


  void _filterStocks() {
    final query = _textController.text.toLowerCase();
    setState(() {
      filteredStockList = stockList.where((stock) {
        final companyName = stock['companyName'].toLowerCase();
        return companyName.contains(query);
      }).toList();
    });
  }

  // bool _toggleWatchlist1(Map<String, dynamic> stock, bool isInWatchlist) {
  //   setState(() {
  //     if (isInWatchlist) {
  //       myList.add(stock);
  //     } else {
  //       myList.removeWhere((item) => item['fav'] == stock['_fav']);
  //     }
  //   });
  //   return myList.any((item) => item['symbol'] == stock['symbol']);
  // }


  @override
  void initState() {
    super.initState();
    loadJsonData();
    _textController.addListener(_filterStocks);
    loadMyList(); // Load the watchlist from SharedPreferences
  }

  Future<void> loadMyList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> myListJson = prefs.getStringList('watchlist') ?? [];
    setState(() {
      myList = myListJson.map((jsonItem) => jsonDecode(jsonItem)).toList();
    });
  }


  Future<void> _toggleWatchlist1(Map<String, dynamic> stock,
      bool isInWatchlist) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> watchlistJson = prefs.getStringList('watchlist') ?? [];

    setState(() {
      if (isInWatchlist) {
        // Remove from watchlist
        watchlistJson.removeWhere((item) =>
        jsonDecode(item)['symbol'] == stock['symbol']);
        myList.removeWhere((item) => item['symbol'] == stock['symbol']);
      } else {
        // Check if list is full
        if (watchlistJson.length >= 2) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The list is full')),
          );
          return;
        }

        // Add to watchlist
        String stockJson = jsonEncode(stock);
        watchlistJson.add(stockJson);
        myList.add(stock);
      }
    });

    await prefs.setStringList('watchlist', watchlistJson);
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
            'Stocklist',
            style: TextStyle(
              color: const Color(0xFF191919),
              fontSize: 18.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: _buildExploreTab(),
    );
  }

  Widget _buildExploreTab() {
    return Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Container(
                  height: 48.h,
                  width: 330.w,
                  padding: EdgeInsets.symmetric(vertical: 0.h),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) => _filterStocks(),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.search,
                    cursorColor: const Color(0xff282828),
                    controller: _textController,
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: const Color(0xFF191919),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.32,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: const Color(0xFF191919),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.32,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: 13.h, bottom: 13),
                        child: Icon(
                          Icons.search,
                          color: Color(0xFF191919),
                          size: 24.sp,
                        ),
                      ),
                      suffixIcon: _textController.text.isEmpty
                          ? SizedBox(width: 10.w)
                          : IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: const Color(0xff282828),
                          size: 20.w,
                        ),
                        onPressed: () {
                          _textController.clear();
                          _filterStocks();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 64.0 * filteredStockList.length,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredStockList.length,
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 0.h),
                  itemBuilder: (BuildContext context, int index) {
                    final stock = filteredStockList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                LiveChart(
                                  stock: stock,
                                  timeFrames: stock['timeFrames'],  // Pass the timeFrames data
                                  onToggleWatchlist: _toggleWatchlist1, isMini: false,  // Pass the callback
                                ),
                          ),
                        );
                      },
                      child: Container(
                        width: 390.w,
                        height: 64.h,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: 10.h),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 260.w,
                                        child: Text(
                                          stock['companyName'] ?? 'N/A',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '₹ ${stock['latestPrice']
                                            .toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: Color(0xFF191919),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${stock['priceChange']>= 0 ? '+' : ''}${stock['priceChange']
                                                .toStringAsFixed(2)}',
                                            style: TextStyle(
                                              color:
                                              stock['priceChange']  >= 0 ? const Color(0xFF04F565)
                                                  : Colors.red,
                                            ),
                                          ),
                                          Text(
                                            ' (${stock['percentageChange']
                                                .toStringAsFixed(2)}%)',
                                            style: TextStyle(
                                              color:
                                              stock['percentageChange']  >= 0 ?  Color(0xFF04F565)
                                                  : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 0.06,
                              color: Colors.black,
                              height: 1.h,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              )
            ],
          ),
        )
    );
  }
}
