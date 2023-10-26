import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sachintha_uee/providers/user_provider.dart';
import 'package:sachintha_uee/utils/constants.dart';

class UserDataContainer extends StatelessWidget {
  final VoidCallback requestManagementClicked;
  final VoidCallback driverClicked;
  final VoidCallback providerClicked;
  const UserDataContainer({
    super.key,
    required this.driverClicked,
    required this.providerClicked,
    required this.requestManagementClicked,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello ${userProvider.currentUser?.name}',
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Here is your pickup list today',
            style: TextStyle(
              fontSize: 17,
            ),
          )
        ],
      ),
    );
  }
}
