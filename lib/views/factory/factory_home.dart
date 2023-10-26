import 'package:flutter/material.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/views/factory/drivers_list.dart';
import 'package:sachintha_uee/views/factory/factory_home_widget.dart';
import 'package:sachintha_uee/views/factory/providers_list.dart';
import 'package:sachintha_uee/views/factory/requests.dart';

class FactoryHome extends StatefulWidget {
  const FactoryHome({super.key});

  @override
  State<FactoryHome> createState() => _FactoryHomeState();
}

class _FactoryHomeState extends State<FactoryHome> {
  List<Widget> get bodies => [
        FactoryHomeWidget(
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
        DriversList(),
        ProvidersList(),
        Requests(),
        Container(),
        Container(),
        Container(),
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
            label: 'Drivers',
            icon: Icon(
              Icons.drive_eta,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Providers',
            icon: Icon(
              Icons.group,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Requests',
            icon: Icon(
              Icons.menu,
            ),
          ),
        ],
      ),
    );
  }
}
