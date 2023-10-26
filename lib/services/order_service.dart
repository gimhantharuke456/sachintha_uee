import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final firebase = FirebaseFirestore.instance;
  Future<void> assaignADriver(
    String orderId,
    String id,
  ) async {
    try {
      print(orderId);
      await firebase.collection("orders").doc(orderId).update({
        "status": "Assaigned",
        "driverId": id,
      });
    } catch (e) {
      throw Error.safeToString(e.toString());
    }
  }

  Future<void> updateStatus(String orderId, String status,
      {double quantity = 0, String note = ""}) async {
    try {
      await firebase.collection("orders").doc(orderId).update({
        "status": status,
        "note": note,
      });
      if (quantity != 0) {
        await firebase.collection("orders").doc(orderId).update({
          "quantity": quantity,
        });
      }
    } catch (e) {
      throw Error.safeToString(e.toString());
    }
  }

  Future<void> cancelOrder(String id) async {
    try {
      await firebase.collection("orders").doc(id).update({
        "status": "Rejected",
      });
    } catch (e) {
      throw Error.safeToString(e.toString());
    }
  }
}
