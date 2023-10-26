import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachintha_uee/models/supply_model.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/custom_states.dart';
import 'package:sachintha_uee/utils/index.dart';
import 'package:sachintha_uee/views/factory/order_view_factory.dart';

class Requests extends StatelessWidget {
  const Requests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Requests",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("orders").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.data == null
              ? const SizedBox()
              : snapshot.data!.docs.isEmpty
                  ? const Center(
                      child: Text("No requests"),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(defaultPadding),
                      children: snapshot.data!.docs.map(
                        (e) {
                          SupplyModel supplyModel =
                              SupplyModel.fromDocumentSnapshot(e);
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(defaultPadding / 2),
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Request ID : ${supplyModel.id!}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Chip(
                                      backgroundColor:
                                          orderStates[supplyModel.status],
                                      label: Text(
                                        supplyModel.status,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  supplyModel.address,
                                  style: const TextStyle(
                                      fontSize: 14, color: Color(0xFF828282)),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                MaterialButton(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  onPressed: () {
                                    context.navigator(
                                        context,
                                        OrderViewFactory(
                                            supplyModel: supplyModel));
                                  },
                                  child: const Text(
                                    "View Details",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    );
        },
      ),
    );
  }
}
