import 'package:flutter/material.dart';
import 'package:sachintha_uee/components/back_row.dart';
import 'package:sachintha_uee/components/main_button.dart';
import 'package:sachintha_uee/models/user_model.dart';
import 'package:sachintha_uee/services/user_service.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/index.dart';

class DriverView extends StatelessWidget {
  final User user;
  const DriverView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            const BackRow(),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name : ${user.name}',
                    ),
                    Text("Contact Number ${user.contactNumber}")
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Supplies",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            Expanded(child: ListView()),
            MainButton(
              color: rejectedColor,
              onPressed: () async {
                try {
                  await UserService().deleteUser(user.id!);
                  Navigator.pop(context);
                } catch (e) {
                  context.showSnackBar(e.toString());
                }
              },
              title: "Remove ${user.role}",
            )
          ],
        ),
      ),
    );
  }
}
