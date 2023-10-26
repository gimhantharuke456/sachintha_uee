import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sachintha_uee/components/address_book.dart';
import 'package:sachintha_uee/providers/user_provider.dart';
import 'package:sachintha_uee/utils/constants.dart';

class ProfileView extends StatelessWidget {
  final bool isDriver;
  const ProfileView({super.key, this.isDriver = false});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3 - 75,
                  color: const Color(0xFF4FAF5A),
                ),
                const Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=3087&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'NIC : ${userProvider.currentUser?.nic}',
            style: const TextStyle(
              color: Color(0xFF4FAF5A),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${userProvider.currentUser?.name}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${userProvider.currentUser?.contactNumber}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Container(
              decoration: BoxDecoration(
                  color: successColor, borderRadius: BorderRadius.circular(12)),
              height: 3,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          if (!isDriver)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Address Book",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          if (!isDriver) AddressBook(padding: defaultPadding),
        ],
      ),
    );
  }
}
