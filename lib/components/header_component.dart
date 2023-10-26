import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sachintha_uee/providers/user_provider.dart';
import 'package:sachintha_uee/utils/index.dart';
import 'package:sachintha_uee/views/auth/login_screen.dart';

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              provider.logout();
              context.navigator(context, LoginScreen(), shouldBack: false);
            },
            child: const ClipOval(
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
    );
  }
}
