import 'package:flutter/material.dart';

import 'package:sachintha_uee/components/input_field.dart';

import 'package:sachintha_uee/components/main_button.dart';
import 'package:sachintha_uee/components/sub_title.dart';

import 'package:sachintha_uee/services/user_service.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/index.dart';

class RegiserNewDriver extends StatefulWidget {
  final String role;
  const RegiserNewDriver({
    super.key,
    this.role = "driver",
  });

  @override
  State<RegiserNewDriver> createState() => _RegiserNewDriverState();
}

class _RegiserNewDriverState extends State<RegiserNewDriver> {
  final nic = TextEditingController();

  final driverName = TextEditingController();

  final contactNumber = TextEditingController();

  final password = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _key,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: kToolbarHeight,
                      ),
                      SubTitle(title: 'Register new ${widget.role}'),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomInputField(
                        label: 'Enter ${widget.role} NIC',
                        hint: 'Enter ${widget.role} NIC',
                        controller: nic,
                      ),
                      CustomInputField(
                        label: 'Enter ${widget.role} Name',
                        hint: 'Enter ${widget.role} Name',
                        controller: driverName,
                      ),
                      CustomInputField(
                        label: 'Enter ${widget.role} Contact Number',
                        hint: 'Enter ${widget.role} Contact Number',
                        controller: contactNumber,
                      ),
                      CustomInputField(
                        label: 'Enter ${widget.role} Password',
                        hint: 'Enter ${widget.role} Password',
                        controller: password,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: MainButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      title: 'Cancel',
                      color: const Color(
                        0xFFD34F4F,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: MainButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          try {
                            await UserService().addUser(
                              nic.text,
                              driverName.text,
                              password.text,
                              widget.role,
                              contactNumber.text,
                            );
                            context.showSnackBar(
                                '${widget.role} added succesfully');
                            nic.clear();
                            driverName.clear();
                            password.clear();
                            contactNumber.clear();
                            setState(() {});
                          } catch (e) {
                            context.showSnackBar(e.toString());
                          }
                        }
                      },
                      title: 'Add ${widget.role}',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
