import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sachintha_uee/components/header_component.dart';
import 'package:sachintha_uee/components/main_button.dart';
import 'package:sachintha_uee/providers/selected_order_provider.dart';
import 'package:sachintha_uee/services/order_service.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/custom_states.dart';
import 'package:sachintha_uee/utils/index.dart';
import 'package:sachintha_uee/views/driver/driver_home.dart';
import 'package:sachintha_uee/views/driver/order_confirm_details.dart';

class CompleteOrder extends StatelessWidget {
  const CompleteOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectedSupplyModel selectedSupplyModel =
        Provider.of<SelectedSupplyModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const HeaderComponent(),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
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
                                "Request ID : ${selectedSupplyModel.selectedSupplyModel?.id}",
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
                              backgroundColor: orderStates[selectedSupplyModel
                                  .selectedSupplyModel?.status],
                              label: Text(
                                selectedSupplyModel
                                        .selectedSupplyModel?.status ??
                                    '',
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
                                  selectedSupplyModel
                                          .selectedSupplyModel?.address ??
                                      '',
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
                          "Estimated Quantity : ${selectedSupplyModel.selectedSupplyModel?.quantity}kg",
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
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Flexible(
                  child: MainButton(
                    onPressed: () async {
                      try {
                        await OrderService().updateStatus(
                            selectedSupplyModel.selectedSupplyModel?.id ?? '',
                            "Rejected");
                        context.navigator(context, DriverHome(),
                            shouldBack: false);
                      } catch (e) {
                        context.showSnackBar(e.toString());
                      }
                    },
                    color: rejectedColor,
                    textColor: Colors.white,
                    title: "Cancel Pickup",
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Flexible(
                  child: MainButton(
                    onPressed: () async {
                      try {
                        context.navigator(
                          context,
                          const OrderConfirmDetailsScreen(),
                        );
                      } catch (e) {
                        context.showSnackBar(e.toString());
                      }
                    },
                    title: "Confirm Pickup",
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
