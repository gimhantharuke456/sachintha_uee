import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachintha_uee/components/header_component.dart';
import 'package:sachintha_uee/components/input_field.dart';
import 'package:sachintha_uee/components/main_button.dart';
import 'package:sachintha_uee/models/supply_model.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/custom_states.dart';
import 'package:sachintha_uee/utils/index.dart';
import 'package:sachintha_uee/views/supplier/supplier_home.dart';

class OrderView extends StatefulWidget {
  final SupplyModel order;
  const OrderView({
    super.key,
    required this.order,
  });

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final TextEditingController estimatedQty = TextEditingController();
  final TextEditingController address = TextEditingController();

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
                          "Request ID : ${widget.order.id}",
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
                        backgroundColor: orderStates[widget.order.status],
                        label: Text(
                          widget.order.status,
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
                            widget.order.address,
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
                    "Estimated Quantity : ${widget.order.quantity}kg",
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
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: MainButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("orders")
                          .doc(widget.order.id!)
                          .delete();
                      context.navigator(context, SupplierHome(),
                          shouldBack: false);
                    },
                    title: "Cancel Request",
                    color: rejectedColor,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: MainButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          estimatedQty.text = widget.order.quantity.toString();
                          address.text = widget.order.address;

                          return Dialog(
                            child: Container(
                              padding: const EdgeInsets.all(defaultPadding),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomInputField(
                                    label: "Estimated Qty",
                                    hint: "Estimated Qty",
                                    controller: estimatedQty,
                                    inputType: TextInputType.number,
                                  ),
                                  CustomInputField(
                                    label: "Address",
                                    hint: "Address",
                                    controller: address,
                                  ),
                                  MainButton(
                                    onPressed: () async {
                                      if (estimatedQty.text.isNotEmpty &&
                                          address.text.isNotEmpty) {
                                        try {
                                          await FirebaseFirestore.instance
                                              .collection("orders")
                                              .doc(widget.order.id)
                                              .update({
                                            "address": address.text,
                                            "quantity":
                                                double.parse(estimatedQty.text),
                                          });
                                          Navigator.pop(context);
                                          context.showSnackBar(
                                              "Request updated successfully");
                                          context.navigator(
                                              context, SupplierHome());
                                        } catch (e) {
                                          context.showSnackBar('$e');
                                        }
                                      }
                                    },
                                    title: "Update",
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    title: "Edit Details",
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
