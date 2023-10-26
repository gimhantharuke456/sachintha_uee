import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sachintha_uee/components/header_component.dart';
import 'package:sachintha_uee/components/input_field.dart';
import 'package:sachintha_uee/components/main_button.dart';
import 'package:sachintha_uee/providers/selected_order_provider.dart';
import 'package:sachintha_uee/services/order_service.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/index.dart';
import 'package:sachintha_uee/views/driver/qr_view.dart';

class OrderConfirmDetailsScreen extends StatefulWidget {
  const OrderConfirmDetailsScreen({super.key});

  @override
  State<OrderConfirmDetailsScreen> createState() =>
      _OrderConfirmDetailsScreenState();
}

class _OrderConfirmDetailsScreenState extends State<OrderConfirmDetailsScreen> {
  final qty = TextEditingController();
  final note = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final SelectedSupplyModel selectedSupplyModel =
        Provider.of<SelectedSupplyModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderComponent(),
            const SizedBox(
              height: 32,
            ),
            const Text(
              "Enter pickup quantity",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomInputField(
                    controller: qty,
                    hint: "Enter quantity",
                    label: "Quantity",
                    inputType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "/ kg",
                  style: TextStyle(
                    fontSize: 16,
                    color: successColor,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              "Notes",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: "Note",
                hintText: "Note",
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Flexible(
                  child: MainButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    color: Colors.black,
                    textColor: Colors.white,
                    title: "Back",
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Flexible(
                  child: MainButton(
                    onPressed: () async {
                      try {
                        if (qty.text.isNotEmpty) {
                          await OrderService().updateStatus(
                            selectedSupplyModel.selectedSupplyModel?.id ?? '',
                            "Completed",
                            quantity: double.parse(qty.text),
                            note: note.text,
                          );
                          context.navigator(
                            context,
                            QrScanView(),
                          );
                        } else {
                          context.showSnackBar("Enter quantity");
                        }
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
