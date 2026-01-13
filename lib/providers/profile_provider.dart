import 'dart:io';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String? _userType;
  File? _profileImage;

  String? get userType => _userType;
  File? get profileImage => _profileImage;

  void setUserType(String type) {
    _userType = type;
    notifyListeners();
  }

  void setProfileImage(File image) {
    _profileImage = image;
    notifyListeners();
  }

  void resetProfile() {
    _userType = null;
    _profileImage = null;
    notifyListeners();
  }
}
