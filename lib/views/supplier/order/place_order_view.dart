import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sachintha_uee/components/header_component.dart';
import 'package:sachintha_uee/components/input_field.dart';
import 'package:sachintha_uee/components/main_button.dart';
import 'package:sachintha_uee/components/map_screen.dart';
import 'package:sachintha_uee/providers/place_order_provider.dart';
import 'package:sachintha_uee/providers/user_provider.dart';
import 'package:sachintha_uee/services/custom_location_service.dart';
import 'package:sachintha_uee/utils/constants.dart';
import 'package:sachintha_uee/utils/index.dart';
import 'package:sachintha_uee/views/supplier/supplier_home.dart';

enum OrderPlaceStates {
  choose_address,
  choose_location,
  estimated_qty,
  successfull,
}

class PlaceOrderView extends StatefulWidget {
  const PlaceOrderView({super.key});

  @override
  State<PlaceOrderView> createState() => _PlaceOrderViewState();
}

class _PlaceOrderViewState extends State<PlaceOrderView> {
  OrderPlaceStates state = OrderPlaceStates.choose_address;
  final addressline1 = TextEditingController();
  final addressline2 = TextEditingController();
  final addressline3 = TextEditingController();
  final qty = TextEditingController();
  bool loading = false;
  Position? currentLocation;
  LatLng? selectedLocation;
  void onLocationPicked(LatLng location) {
    selectedLocation = location;
  }

  @override
  void initState() {
    CustomLocationService()
        .getCurrentLocation()
        .then((value) => setState(() {
              currentLocation = value;
            }))
        .catchError((onError) {
      context.showSnackBar(onError);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PlaceOrderProvider placeOrderProvider =
        Provider.of<PlaceOrderProvider>(context);
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderComponent(),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      stepCard(true, "1", "Choose Address"),
                      stepDivider(
                        state == OrderPlaceStates.choose_location ||
                            state == OrderPlaceStates.estimated_qty,
                      ),
                      stepCard(
                          state == OrderPlaceStates.choose_location ||
                              state == OrderPlaceStates.estimated_qty,
                          "2",
                          "Choose Location"),
                      stepDivider(
                        state == OrderPlaceStates.estimated_qty,
                      ),
                      stepCard(state == OrderPlaceStates.estimated_qty, "3",
                          "Estimated Qty"),
                      stepDivider(
                        state == OrderPlaceStates.successfull,
                      ),
                      stepCard(state == OrderPlaceStates.successfull, "4",
                          "Success"),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (state == OrderPlaceStates.choose_address)
                    const Text(
                      'Choose Pickup Location',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  if (state == OrderPlaceStates.choose_address)
                    Expanded(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("address")
                            .where(
                              "address_of",
                              isEqualTo: FirebaseAuth.instance.currentUser?.uid,
                            )
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          return snapshot.data != null
                              ? ListView(
                                  children: snapshot.data!.docs
                                      .map(
                                        (e) => GestureDetector(
                                          onTap: () {
                                            placeOrderProvider.setAddress =
                                                '${e['address_01']},${e['address_02']},${e['city']}';
                                            setState(() {
                                              state = OrderPlaceStates
                                                  .choose_location;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colors.white),
                                            padding: const EdgeInsets.all(
                                                defaultPadding),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${e['address_01']},${e['address_02']},${e['city']}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                const Text(
                                                  "Pick on map >> ",
                                                  style: TextStyle(
                                                    color: successColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              : const SizedBox();
                        },
                      ),
                    ),
                  if (state == OrderPlaceStates.choose_address)
                    Align(
                      alignment: Alignment.center,
                      child: MainButton(
                          color: Colors.white,
                          textColor: Colors.black,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomInputField(
                                            label: "Address line 01",
                                            hint: "Address line 01",
                                            controller: addressline1,
                                          ),
                                          CustomInputField(
                                            label: "Address line 02",
                                            hint: "Address line 02",
                                            controller: addressline2,
                                          ),
                                          CustomInputField(
                                            label: "City",
                                            hint: "City",
                                            controller: addressline3,
                                          ),
                                          MainButton(
                                            onPressed: () async {
                                              if (addressline1
                                                  .text.isNotEmpty) {
                                                await FirebaseFirestore.instance
                                                    .collection("address")
                                                    .add({
                                                  "address_of": FirebaseAuth
                                                      .instance
                                                      .currentUser
                                                      ?.uid,
                                                  "address_01":
                                                      addressline1.text,
                                                  "address_02":
                                                      addressline2.text,
                                                  "city": addressline3.text,
                                                });
                                                addressline1.clear();
                                                addressline2.clear();
                                                addressline3.clear();
                                                setState(() {});
                                                Navigator.pop(context);
                                              }
                                            },
                                            title: "Add",
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          title: "+ Add New"),
                    ),
                  if (state == OrderPlaceStates.choose_location)
                    if (currentLocation != null)
                      Expanded(
                        child: MapScreen(
                          canEdit: true,
                          initialPosition: LatLng(
                            currentLocation!.latitude,
                            currentLocation!.longitude,
                          ),
                          onLocationPicked: onLocationPicked,
                        ),
                      ),
                  if (state == OrderPlaceStates.choose_location)
                    MainButton(
                        onPressed: () {
                          if (selectedLocation != null) {
                            placeOrderProvider.latitude =
                                selectedLocation!.latitude;
                            placeOrderProvider.longitude =
                                selectedLocation!.longitude;
                          } else {
                            context.showSnackBar("Please pick a location");
                            return;
                          }
                          setState(() {
                            state = OrderPlaceStates.estimated_qty;
                          });
                        },
                        title: "Pick Location"),
                  if (state == OrderPlaceStates.estimated_qty)
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'Enter Estimated Quantity',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomInputField(
                            label: "Estimated Quantity",
                            hint: "Estimated Quantity",
                            controller: qty,
                            inputType: TextInputType.number,
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text("Dont need to enter exact amount"),
                          ),
                        ],
                      ),
                    ),
                  if (state == OrderPlaceStates.estimated_qty)
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: MainButton(
                            onPressed: () {
                              setState(() {
                                state = OrderPlaceStates.choose_location;
                              });
                            },
                            color: Colors.black,
                            title: "Back",
                            textColor: Colors.white,
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: MainButton(
                            onPressed: () async {
                              if (qty.text.isNotEmpty) {
                                setState(() {
                                  loading = true;
                                });
                                placeOrderProvider.setQty =
                                    double.parse(qty.text);
                                final UserProvider provider =
                                    Provider.of<UserProvider>(context);
                                try {
                                  await placeOrderProvider.placeOrder(
                                      provider.currentUser?.nic ?? '');
                                  setState(() {
                                    state = OrderPlaceStates.successfull;
                                    loading = false;
                                  });
                                } catch (e) {
                                  context.showSnackBar(
                                      "Order place failed!. Try again");
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              } else {
                                context.showSnackBar("Please enter estimation");
                              }
                            },
                            title: "Next",
                          ),
                        ),
                      ],
                    ),
                  if (state == OrderPlaceStates.successfull)
                    Column(
                      children: [
                        Image.asset(
                          "assets/success.png",
                          width: 292,
                          fit: BoxFit.fitWidth,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Text(
                          "Request placed successfully",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Text(
                          "You can monitor  the progress in request list",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        MainButton(
                            onPressed: () {
                              context.navigator(
                                context,
                                SupplierHome(),
                                shouldBack: false,
                              );
                            },
                            title: "View Requests")
                      ],
                    )
                ],
              ),
            ),
    );
  }

  Expanded stepDivider(bool active) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        height: 5,
        decoration: BoxDecoration(
            color: active ? const Color(0xFF4FAF5A) : const Color(0xFF969696),
            borderRadius: BorderRadius.circular(40)),
      ),
    );
  }

  SizedBox stepCard(bool active, String title, String subTitle) {
    return SizedBox(
      width: 55,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? const Color(0xFF4FAF5A) : const Color(0xFF969696),
            ),
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: active ? const Color(0xFF4FAF5A) : const Color(0xFF969696),
            ),
          )
        ],
      ),
    );
  }
}
