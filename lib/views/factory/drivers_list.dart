import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachintha_uee/components/header_component.dart';
import 'package:sachintha_uee/components/loading.dart';
import 'package:sachintha_uee/components/sub_title.dart';
import 'package:sachintha_uee/models/user_model.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/index.dart';
import 'package:sachintha_uee/views/factory/driver_view.dart';
import 'package:sachintha_uee/views/factory/register_new_driver.dart';

class DriversList extends StatelessWidget {
  const DriversList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.navigator(context, RegiserNewDriver());
        },
        label: const Text('Add Driver'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('role', isEqualTo: 'driver')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No drivers availble successully'),
              );
            }
            return Container(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderComponent(),
                  const SubTitle(title: 'Drivers'),
                  Expanded(
                    child: ListView(
                      children: snapshot.data!.docs.map((e) {
                        User user = User.fromDocumentSnapshot(e);
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(bottom: 8),
                            height: 64,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              onTap: () {
                                context.navigator(
                                    context, DriverView(user: user));
                              },
                              leading: const CircleAvatar(
                                child: Icon(
                                  Icons.person,
                                ),
                              ),
                              title: Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: const Text(
                                'View Profile',
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                            ));
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
