import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sachintha_uee/components/header_component.dart';
import 'package:sachintha_uee/components/main_button.dart';
import 'package:sachintha_uee/components/user_data_container.dart';
import 'package:sachintha_uee/models/supply_model.dart';
import 'package:sachintha_uee/providers/selected_order_provider.dart';
import 'package:sachintha_uee/providers/user_provider.dart';
import 'package:sachintha_uee/utils/constants.dart';

class DriverHomeWidget extends StatefulWidget {
  final VoidCallback onSelectOrder;
  const DriverHomeWidget({super.key, required this.onSelectOrder});

  @override
  State<DriverHomeWidget> createState() => _DriverHomeWidgetState();
}

class _DriverHomeWidgetState extends State<DriverHomeWidget> {
  SupplyModel? selectedSupplyModel;

  @override
  Widget build(BuildContext context) {
    final SelectedSupplyModel sp = Provider.of(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderComponent(),
            UserDataContainer(
              requestManagementClicked: () {},
              driverClicked: () {},
              providerClicked: () {},
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("orders")
                    .where("driverId",
                        isEqualTo: userProvider.currentUser?.nic ?? '')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return snapshot.data == null
                      ? const SizedBox()
                      : ListView(
                          children: snapshot.data!.docs.map((e) {
                            SupplyModel supplyModel =
                                SupplyModel.fromDocumentSnapshot(e);
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSupplyModel = supplyModel;
                                  sp.selectedSupplyModel = selectedSupplyModel;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(bottom: 4),
                                decoration: BoxDecoration(
                                  color: selectedSupplyModel == supplyModel
                                      ? successColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          e.id,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        if (supplyModel.status != "Completed")
                                          const Chip(
                                            backgroundColor: orange,
                                            label: Text(
                                              "Pickup",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      supplyModel.address,
                                    ),
                                    MaterialButton(
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      onPressed: () {},
                                      child: const Text(
                                        "View Details",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                },
              ),
            ),
            if (selectedSupplyModel != null)
              MainButton(
                onPressed: () {
                  if (sp.selectedSupplyModel != null) {
                    widget.onSelectOrder();
                  } else {
                    print("cas");
                  }
                },
                title: "Start Journey",
              ),
          ],
        ),
      ),
    );
  }
}
