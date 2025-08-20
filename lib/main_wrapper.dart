import 'package:chillflix_app/product/widgets/custom_nav_bar.dart';
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
    const HomeView(), // Mevcut ana sayfa
    const SearchView(), // Arama/Keşfet sayfası
    const ProfileView(), // Profil sayfası
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

// Geçici Search View - Gerçek search ekranınızla değiştirin
class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.blackColor,
        title: const Text(
          'Keşfet',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Keşfet Sayfası',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}

// Geçici Profile View - Gerçek profil ekranınızla değiştirin
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.blackColor,
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Profil Sayfası',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}