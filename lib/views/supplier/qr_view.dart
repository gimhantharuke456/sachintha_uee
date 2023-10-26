import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sachintha_uee/providers/user_provider.dart';
import 'package:sachintha_uee/utils/constants.dart';

class QrView extends StatelessWidget {
  const QrView({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              QrImageView(
                data: '${userProvider.currentUser?.id}',
                version: QrVersions.auto,
                size: 320,
                gapless: false,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    "Use this QR code to confirm the pickup",
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Text(
                  textAlign: TextAlign.center,
                  "Make sure to check the quantity before providing th QR",
                  style: TextStyle(color: primaryColor),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
