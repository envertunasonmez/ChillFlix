import 'package:chillflix_app/product/widgets/custom_nav_bar.dart';
import 'package:chillflix_app/views/discover/discover_view.dart';
import 'package:chillflix_app/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/views/home/home_view.dart';
import 'package:chillflix_app/cubit/movies/movies_cubit.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  // Add your screens here
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
    return BlocProvider(
      create: (context) => MoviesCubit(),
      child: Scaffold(
        backgroundColor: ColorConstants.blackColor,
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }
}
