import 'package:flutter/material.dart';
import 'package:sachintha_uee/components/order_book.dart';
import 'package:sachintha_uee/components/header_component.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/index.dart';
import 'package:sachintha_uee/views/supplier/order/place_order_view.dart';

class Supplies extends StatelessWidget {
  const Supplies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.navigator(
              context,
              const PlaceOrderView(),
            );
          },
          label: const Text("Add Request")),
      body: const Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            HeaderComponent(),
            OrderBook(),
          ],
        ),
      ),
    );
  }
}
