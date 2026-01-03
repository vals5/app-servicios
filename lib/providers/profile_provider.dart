import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String? _userType;

  String? get userType => _userType;

  void setUserType(String type) {
    _userType = type;
    notifyListeners();
  }

  // -------------------------
  // PERFIL COMPLETADO (%)
  // -------------------------

  int _profileProgress = 0;
  int get profileProgress => _profileProgress;

  void updateProfileProgress(int value) {
    _profileProgress = value;
    notifyListeners();
  }

  // -------------------------
  // RESET (por si cambia tipo)
  // -------------------------

  void resetProfile() {
    _userType = null;
    _profileProgress = 0;
    notifyListeners();
  }
}
