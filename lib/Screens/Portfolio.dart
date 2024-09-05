import 'package:flutter/material.dart';
class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xffEBFCF8),
      body: Column(
        children: [
          Center(child: Text('Coming Soon........'))
        ],
      ),
    );
  }
}
