import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sachintha_uee/models/supply_model.dart';

class PlaceOrderProvider with ChangeNotifier {
  String address = "";
  double latitude = 0;
  double longitude = 0;
  double estimatedQty = 0;

  set setAddress(String val) {
    address = val;
    notifyListeners();
  }

  set setLat(double lat) {
    latitude = lat;
    notifyListeners();
  }

  set setLon(double lon) {
    longitude = lon;
    notifyListeners();
  }

  set setQty(double lon) {
    estimatedQty = lon;
    notifyListeners();
  }

  Future<void> placeOrder(String id) async {
    try {
      SupplyModel supplyModel = SupplyModel(
        suppliedBy: id,
        suppliedAt: DateTime.now(),
        status: "In Progress",
        latitude: latitude,
        longitude: longitude,
        address: address,
        quantity: estimatedQty,
      );
      await FirebaseFirestore.instance.collection('orders').add(
            supplyModel.toMap(),
          );
    } catch (e) {
      throw Error.safeToString(e.toString());
    }
  }
}
