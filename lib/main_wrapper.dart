import 'package:chillflix_app/product/widgets/custom_nav_bar.dart';
import 'package:chillflix_app/views/discover/discover_view.dart';
import 'package:chillflix_app/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/views/home/home_view.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  // Farklı ekranlarınızı buraya ekleyin
  final List<Widget> _screens = [
    const HomeView(),
    DiscoverView(),
    const ProfileView(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
