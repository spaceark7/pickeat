import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickeat_app/ui/restaurantListScreen.dart';
import 'package:pickeat_app/widgets/platformWidget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;

  List<Widget> _listWidget = [
    RestaurantListScreen(),
    Placeholder(),
    Placeholder()
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.heart : Icons.favorite),
        label: 'Favorite'),
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.person : Icons.person),
        label: 'Profile'),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIOS(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: _bottomNavBarItems,
        ),
        tabBuilder: (context, index) {
          return _listWidget[index];
        });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }
}
