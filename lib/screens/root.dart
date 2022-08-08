import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dhiigplus/screens/home.dart';
import 'package:dhiigplus/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'findDonor.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          selectedTab(2);
        },
        backgroundColor: primary,
        child: const Icon(
          CupertinoIcons.drop_fill,
          size: 25,
        ),
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      const Home(),
      const ProfilePage(),
      const FindDonor(),
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Icons.home,
      Icons.person,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: primary,
      splashColor: secondary,
      inactiveColor: Colors.black,
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 30,
      rightCornerRadius: 10,
      onTap: (index) {
        selectedTab(index);
      },
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
