import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBFCF8),
      appBar: AppBar(
        leadingWidth: 100.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w, top: 20.h),
          child: Text(
            'Portfolio',
            style: TextStyle(
              color: const Color(0xFF191919),
              fontSize: 18.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'Coming Soon........',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Montserrat',
            ),
          ))
        ],
      ),
    );
  }
}
