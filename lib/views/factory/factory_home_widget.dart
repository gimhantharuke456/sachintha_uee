import 'package:flutter/material.dart';
import 'package:sachintha_uee/components/header_component.dart';
import 'package:sachintha_uee/components/user_data_container.dart';
import 'package:sachintha_uee/utils/constants.dart';

class FactoryHomeWidget extends StatelessWidget {
  final VoidCallback requestManagementClicked;
  final VoidCallback driverClicked;
  final VoidCallback providerClicked;
  const FactoryHomeWidget({
    super.key,
    required this.driverClicked,
    required this.providerClicked,
    required this.requestManagementClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderComponent(),
            UserDataContainer(
              requestManagementClicked: requestManagementClicked,
              driverClicked: driverClicked,
              providerClicked: providerClicked,
            ),
            GestureDetector(
              onTap: () {
                requestManagementClicked();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 96,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/request_logo.png',
                      width: 43,
                      height: 43,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Text(
                      'Request Management',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    providerClicked();
                  },
                  child: Container(
                    width: 153,
                    height: 153,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 53,
                          height: 53,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: primaryColor,
                              width: 4,
                            ),
                          ),
                          child: Image.asset(
                            'assets/users.png',
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Providers',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    driverClicked();
                  },
                  child: Container(
                    width: 153,
                    height: 153,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 53,
                          height: 53,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: primaryColor,
                              width: 4,
                            ),
                          ),
                          child: Image.asset(
                            'assets/truck.png',
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Drivers',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
