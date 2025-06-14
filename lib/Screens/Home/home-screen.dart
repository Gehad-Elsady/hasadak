import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hasadak/Screens/Home/crops/crops_screen.dart';
import 'package:hasadak/Screens/Home/engineers/engineers.dart';
import 'package:hasadak/Screens/Home/equipment/equipment.dart';
import 'package:hasadak/Screens/Home/seeds/seeds-screen.dart';
import 'package:hasadak/Screens/Home/share%20land/share_land.dart';
import 'package:hasadak/photos/images.dart';
import 'package:hasadak/widget/Drawer/mydrawer.dart';

import 'Welcom/welcome-screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              Photos.logo,
              scale: 12,
            ),
            SizedBox(width: 10),
            Text(
              'app_title'.tr(),
              style: GoogleFonts.domine(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF56ab91),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF344e41),
        selectedItemColor: Color(0xFF88D4AB),
        unselectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/cultivator_9466919.png"),
              size: 30,
            ),
            label: "equipment".tr(),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/sesame-seeds_7407779.png"),
              size: 30,
            ),
            label: "seeds".tr(),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/sale.png"),
              size: 30,
            ),
            label: "crops".tr(),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/worker_1839274.png"),
              size: 30,
            ),
            label: "engineers".tr(),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                  "assets/images/environmental-stewardship_18455514.png"),
              size: 30,
            ),
            label: "share_land".tr(),
          ),
        ],
      ),
      body: screens[selectedIndex],
    );
  }

  List<Widget> screens = [
    WelcomeScreen(),
    EquipmentScreen(),
    SeedsScreen(),
    CropsScreen(),
    Engineers(),
    ShareLand()
  ];
}
