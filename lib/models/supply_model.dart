import 'package:cloud_firestore/cloud_firestore.dart';

class SupplyModel {
  final String? id;
  final String suppliedBy;
  final DateTime suppliedAt;
  final String status;
  final double latitude;
  final double longitude;
  final String address;
  final double quantity;

  SupplyModel({
    this.id,
    required this.suppliedBy,
    required this.suppliedAt,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.quantity,
  });

  factory SupplyModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return SupplyModel(
      id: snapshot.id,
      suppliedBy: data['suppliedBy'] ?? '',
      suppliedAt: DateTime.parse(data['suppliedAt']),
      status: data['status'] ?? '',
      latitude: data['latitude'].toDouble(),
      longitude: data['longitude'].toDouble(),
      address: data['address'] ?? '',
      quantity: data['quantity'].toDouble(),
    );
  }

  factory SupplyModel.fromMap(Map<String, dynamic> map, String? id) {
    return SupplyModel(
      id: id,
      suppliedBy: map['suppliedBy'] ?? '',
      suppliedAt: DateTime.parse(map['suppliedAt']),
      status: map['status'] ?? '',
      latitude: map['latitude'].toDouble(),
      longitude: map['longitude'].toDouble(),
      address: map['address'] ?? '',
      quantity: map['quantity'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'suppliedBy': suppliedBy,
      'suppliedAt': suppliedAt.toIso8601String(),
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'quantity': quantity,
    };
  }
}
