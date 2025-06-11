import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskyapp/services/prefrencesetmanager_service.dart';

import '../../core/constants/storage_key.dart';

class ProfileController with ChangeNotifier {
  String _username = PrefrencesetManagerService().getString(StorageKey.username) ?? '';
  String _userImagePath =
      PrefrencesetManagerService().getString(StorageKey.userImage) ?? '';
  String _motivationQuote =
      PrefrencesetManagerService().getString(StorageKey.motivationQuote) ?? '';
  String get username => _username;
  String get userImagePath => _userImagePath;
  String get motivationQuote => _motivationQuote;

  Future<void> setUserName(String username) async {
    if (username.isNotEmpty) {
      _username = username;
      PrefrencesetManagerService().setString(StorageKey.username, username);
      notifyListeners();
    }
  }

  Future<void> updateUserData(
      String newUsername, String newMotivationQuote) async {
    if (newUsername.isNotEmpty && newMotivationQuote.isNotEmpty) {
      _motivationQuote = newMotivationQuote;
      _username = newUsername;
      PrefrencesetManagerService().setString(StorageKey.username, newUsername);
      PrefrencesetManagerService()
          .setString(StorageKey.motivationQuote, newMotivationQuote);
      notifyListeners();
    }
  }

  Future<void> clearUserData() async {
    _username = '';
    _motivationQuote = '';
    _userImagePath = '';
    PrefrencesetManagerService().remove(StorageKey.username);
    PrefrencesetManagerService().remove(StorageKey.motivationQuote);
    PrefrencesetManagerService().remove(StorageKey.userImage);
    notifyListeners();
  }

  // save user image
  void saveUserImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    PrefrencesetManagerService().setString(StorageKey.userImage, newFile.path);
    _userImagePath = newFile.path;
    notifyListeners();
  }
}