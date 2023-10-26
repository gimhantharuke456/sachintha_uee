import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sachintha_uee/components/input_field.dart';
import 'package:sachintha_uee/components/loading_wrapper.dart';
import 'package:sachintha_uee/components/main_button.dart';
import 'package:sachintha_uee/models/user_model.dart';
import 'package:sachintha_uee/providers/loading_provider.dart';
import 'package:sachintha_uee/providers/user_provider.dart';
import 'package:sachintha_uee/services/auth_service.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/index.dart';
import 'package:sachintha_uee/views/auth/auth_checker.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final nic = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return LoadingWrapper(
      secondScreen: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(defaultPadding),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Image.asset('assets/logo.png'),
                CustomInputField(
                  label: 'Enter your nic number',
                  hint: 'Enter your nic number',
                  controller: nic,
                ),
                CustomInputField(
                  label: 'Enter your password',
                  hint: 'Enter your password',
                  controller: password,
                  isPassword: true,
                ),
                MainButton(
                  onPressed: () async {
                    try {
                      loadingProvider.updateLoadingState(state: true);
                      final User? user =
                          await AuthService().login(nic.text, password.text);
                      if (user != null) {
                        userProvider.setCurrentUser(user);
                        loadingProvider.updateLoadingState(state: false);
                        context.navigator(context, AuthChecker(),
                            shouldBack: false);
                        loadingProvider.updateLoadingState(state: false);
                      } else {
                        context.showSnackBar('User not found');
                      }
                      loadingProvider.updateLoadingState(state: false);
                    } catch (e) {
                      context.showSnackBar(e.toString());
                    }
                  },
                  title: "Continue",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
