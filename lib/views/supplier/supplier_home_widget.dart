import 'package:flutter/material.dart';
import 'package:sachintha_uee/components/header_component.dart';
import 'package:sachintha_uee/components/user_data_container.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/index.dart';
import 'package:sachintha_uee/views/supplier/qr_view.dart';

String u = "https://www.qrstuff.com/images/default_qrcode.png";

class SupplierHomeWidget extends StatelessWidget {
  const SupplierHomeWidget(
      {super.key,
      required this.requestManagementClicked,
      required this.driverClicked,
      required this.providerClicked});
  final VoidCallback requestManagementClicked;
  final VoidCallback driverClicked;
  final VoidCallback providerClicked;
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
            Row(
              children: [
                btn(context, "My QR", () {
                  context.navigator(context, QrView());
                }),
                const SizedBox(
                  width: 16,
                ),
                btn(context, "Requests", () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Flexible btn(BuildContext context, String title, VoidCallback callback) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          callback();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              (title == "Requests")
                  ? Image.asset(
                      'assets/request_logo.png',
                      width: 43,
                      height: 43,
                    )
                  : Image.network(
                      u,
                      width: 43,
                      height: 43,
                    ),
              const SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
