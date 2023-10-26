import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sachintha_uee/components/map_screen.dart';
import 'package:sachintha_uee/providers/selected_order_provider.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/index.dart';
import 'package:sachintha_uee/views/driver/complete_order.dart';

class DriverMap extends StatelessWidget {
  const DriverMap({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectedSupplyModel sp = Provider.of<SelectedSupplyModel>(context);
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (sp.selectedSupplyModel == null)
              const Center(
                child: Text("No picked orders"),
              ),
            if (sp.selectedSupplyModel != null)
              MapScreen(
                initialPosition: LatLng(
                  sp.selectedSupplyModel!.latitude,
                  sp.selectedSupplyModel!.longitude,
                ),
                canEdit: false,
                isRoute: true,
              ),
            if (sp.selectedSupplyModel != null)
              Positioned(
                top: 32,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.all(defaultPadding),
                  padding: const EdgeInsets.all(defaultPadding / 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Request Id : ${sp.selectedSupplyModel?.id}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: successColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${sp.selectedSupplyModel?.address}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${sp.selectedSupplyModel?.quantity} KG',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23)),
                        onPressed: () {
                          context.navigator(context, CompleteOrder());
                        },
                        color: Colors.black,
                        child: const Text(
                          "Complete",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
