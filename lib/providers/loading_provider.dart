import 'package:flutter/foundation.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void updateLoadingState({required bool state}) {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
