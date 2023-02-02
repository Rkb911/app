import 'package:flutter/material.dart';

import 'package:testapp/views/home_view.dart';
import 'package:testapp/views/profile_view.dart';
import 'package:testapp/views/saved_view.dart';

import 'package:unicons/unicons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    const Tab(text: "For you"),
    const Tab(text: "Categories"),
  ];
  final List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
        icon: Icon(Icons.bookmark_outline),
        activeIcon: Icon(Icons.bookmark),
        label: 'Saved'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(UniconsLine.user),
        activeIcon: Icon(UniconsLine.user),
        label: 'Profile'),
  ];
  int _selectedIndex = 1;

  TabController? _tabController;

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      const SavedView(),
      HomeView(tabController: _tabController!),
      const ProfileView(),
    ];

    return Scaffold(
      extendBody: true,
      drawer: const Drawer(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            elevation: 8.0,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: items,
          ),
        ),
      ),
      body: pages[_selectedIndex],
    );
  }
}
