import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sachintha_uee/components/main_button.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/index.dart';

class QrScanView extends StatefulWidget {
  const QrScanView({super.key});

  @override
  State<QrScanView> createState() => _QrViewState();
}

class _QrViewState extends State<QrScanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 400,
              child: MobileScanner(
                onDetect: (val) {
                  context.showSnackBar("Order completed successfully");
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Scanning ...",
              style: TextStyle(
                color: successColor,
              ),
            ),
            const Spacer(),
            MainButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
                textColor: Colors.white,
                title: "Cancel")
          ],
        ),
      ),
    );
  }
}
