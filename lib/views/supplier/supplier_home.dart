import 'package:flutter/material.dart';
import 'package:sachintha_uee/views/supplier/profile_view.dart';
import 'package:sachintha_uee/views/supplier/supplier_home_widget.dart';
import 'package:sachintha_uee/views/supplier/supplies.dart';

class SupplierHome extends StatefulWidget {
  const SupplierHome({super.key});

  @override
  State<SupplierHome> createState() => _SupplierHomeState();
}

class _SupplierHomeState extends State<SupplierHome> {
  int activeIndex = 0;
  List<Widget> get bodies => [
        SupplierHomeWidget(
          driverClicked: () {
            setState(() {
              activeIndex = 1;
            });
          },
          providerClicked: () {
            setState(() {
              activeIndex = 2;
            });
          },
          requestManagementClicked: () {
            setState(() {
              activeIndex = 3;
            });
          },
        ),
        Supplies(),
        ProfileView(),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodies[activeIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIndex,
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Requests',
            icon: Icon(Icons.offline_bolt),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
