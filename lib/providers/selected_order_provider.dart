import 'package:flutter/material.dart';
import 'package:sachintha_uee/models/supply_model.dart';

class SelectedSupplyModel with ChangeNotifier {
  SupplyModel? selectedSupplyModel;

  set setSelectedModel(SupplyModel selct) {
    selectedSupplyModel = selct;
    notifyListeners();
  }
}
