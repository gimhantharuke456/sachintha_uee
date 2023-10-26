import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sachintha_uee/providers/loading_provider.dart';
import 'package:sachintha_uee/providers/place_order_provider.dart';
import 'package:sachintha_uee/providers/selected_order_provider.dart';
import 'package:sachintha_uee/providers/user_provider.dart';
import 'package:sachintha_uee/services/local_prefs.dart';
import 'package:sachintha_uee/views/auth/auth_checker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalPreferences localPreferences = LocalPreferences.instance;
  await localPreferences.init();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingProvider>(
          create: (context) => LoadingProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<PlaceOrderProvider>(
          create: (context) => PlaceOrderProvider(),
        ),
        ChangeNotifierProvider<SelectedSupplyModel>(
          create: (context) => SelectedSupplyModel(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        ),
        home: AuthChecker(),
      ),
    );
  }
}
