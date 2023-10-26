import 'package:flutter/material.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/views/driver/driver_home_widget.dart';
import 'package:sachintha_uee/views/driver/driver_map.dart';
import 'package:sachintha_uee/views/supplier/profile_view.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _FactoryHomeState();
}

class _FactoryHomeState extends State<DriverHome> {
  List<Widget> get bodies => [
        DriverHomeWidget(
          onSelectOrder: () {
            setState(() {
              activeIndex = 1;
            });
          },
        ),
        DriverMap(),
        ProfileView(
          isDriver: true,
        ),
      ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodies[activeIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIndex,
        onTap: (val) {
          setState(() {
            activeIndex = val;
          });
        },
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Map',
            icon: Icon(
              Icons.location_on,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
    );
  }
}
