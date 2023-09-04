import 'package:farmy/screens/contact_us_page.dart';
import 'package:farmy/screens/marketplace_page.dart';
import 'package:farmy/screens/scanned_diseases_page.dart';
import 'package:farmy/screens/user_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pages = [
    ScannedDiseasesWidget(),
    MarketplacePage(),
    ContactUsPage(),
    UserPage(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: GNav(
          backgroundColor: Colors.white,
          color: Colors.grey.shade800,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.lightGreen,
          padding: EdgeInsets.all(16),
          selectedIndex: selectedIndex,
          gap: 8,
          onTabChange: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.shopping_bag,
              text: 'Marketplace',
            ),
            GButton(
              icon: Icons.phone,
              text: 'Contact Us',
            ),
            GButton(
              icon: Icons.person,
              text: 'User',
            ),
          ],
        ),
      ),
    );
  }
}
