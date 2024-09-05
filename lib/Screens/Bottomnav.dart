import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradind_app/Screens/Orders.dart';
import 'package:tradind_app/Screens/Portfolio.dart';
import 'package:tradind_app/Screens/Profile.dart';
import 'package:tradind_app/Screens/Watchlist.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}
final screens=[ Watchlist(),Orders(),Portfolio(),Profile()];
int currentIndex=0;
class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      bottomNavigationBar: BottomNavigationBar(currentIndex: currentIndex,onTap: (index){
        setState(() {
          currentIndex=index;
        });
      },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border_outlined,color: Colors.black,), label: "Shop",),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_sharp,color: Colors.black,), label: "Shop"),
          BottomNavigationBarItem(icon:  Icon(Icons.card_travel_outlined,color: Colors.black), label: "Me"),
          BottomNavigationBarItem(icon:  Icon(Icons.person_2_outlined,color: Colors.black), label: "Me"),

        ],
      ),body: screens[currentIndex],

    );
  }
}