import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachintha_uee/components/header_component.dart';
import 'package:sachintha_uee/components/main_button.dart';
import 'package:sachintha_uee/models/supply_model.dart';
import 'package:sachintha_uee/services/order_service.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/custom_states.dart';

class OrderViewFactory extends StatefulWidget {
  final SupplyModel supplyModel;
  const OrderViewFactory({
    super.key,
    required this.supplyModel,
  });

  @override
  State<OrderViewFactory> createState() => _OrderViewFactoryState();
}

class _OrderViewFactoryState extends State<OrderViewFactory> {
  String selectedDriver = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            HeaderComponent(),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Request ID : ${widget.supplyModel.id}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(
                              0xFF606060,
                            ),
                          ),
                        ),
                      ),
                      Chip(
                        backgroundColor: orderStates[widget.supplyModel.status],
                        label: Text(
                          widget.supplyModel.status,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: successColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.supplyModel.address,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "View on map >>",
                              style: TextStyle(
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    height: 8,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Request Details"),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Estimated Quantity : ${widget.supplyModel.quantity}kg",
                    style: const TextStyle(
                        color: Color(
                      0xFF828282,
                    )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    height: 8,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (widget.supplyModel.status != "Rejected")
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: MainButton(
                      color: rejectedColor,
                      onPressed: () async {
                        await OrderService()
                            .cancelOrder(widget.supplyModel.id ?? '');
                        Navigator.pop(context);
                      },
                      title: "Cancel Pickup",
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: MainButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("users")
                                          .where("role", isEqualTo: "driver")
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        return snapshot.data == null
                                            ? const SizedBox()
                                            : ListView(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                children: [
                                                    const Center(
                                                      child: Text(
                                                        "Double tap on driver",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 24,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    ...snapshot.data!.docs
                                                        .map((e) {
                                                      return GestureDetector(
                                                        onDoubleTap: () async {
                                                          setState(() {
                                                            selectedDriver = (e
                                                                    .data()
                                                                as Map)["nic"];
                                                          });
                                                          try {
                                                            await OrderService()
                                                                .assaignADriver(
                                                              widget.supplyModel
                                                                      .id ??
                                                                  '',
                                                              selectedDriver,
                                                            );
                                                          } catch (e) {}
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .lightBlue
                                                                .withOpacity(
                                                                    0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 4),
                                                          child: ListTile(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                            title: Text(
                                                              "Name : ${(e.data() as Map)["name"]}",
                                                              style: const TextStyle(
                                                                  color:
                                                                      successColor),
                                                            ),
                                                            subtitle: Text(
                                                                "Nic ${(e.data() as Map)["nic"]}"),
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ]);
                                      }),
                                ),
                              );
                            });
                      },
                      title: "Assaign Driver",
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
