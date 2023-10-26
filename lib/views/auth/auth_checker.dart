import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sachintha_uee/providers/user_provider.dart';
import 'package:sachintha_uee/views/auth/login_screen.dart';
import 'package:sachintha_uee/views/driver/driver_home.dart';
import 'package:sachintha_uee/views/factory/factory_home.dart';
import 'package:sachintha_uee/views/supplier/supplier_home.dart';

enum AuthStates { userLoggedIn, userNotLoggedIn }

enum Roles { driver, supplier, factory }

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    print(provider.currentUser?.role);
    return provider.currentUser == null
        ? LoginScreen()
        : provider.currentUser?.role == "factory"
            ? FactoryHome()
            : provider.currentUser?.role == "driver"
                ? DriverHome()
                : provider.currentUser?.role == "provider"
                    ? SupplierHome()
                    : LoginScreen();
  }
}
