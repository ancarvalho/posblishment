import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

import '../settings/settings_store.dart';

class EstablishmentController extends Disposable with ChangeNotifier {
  final establishmentNameTextController = TextEditingController();
  final establishmentLocalTextController = TextEditingController();
  final establishmentImagePathTextController = TextEditingController();
  final settingsStore = Modular.get<SettingStore>();

  File? image;
  // String? imagePath;
  final _picker = ImagePicker();

  EstablishmentTypes _establishmentType = EstablishmentTypes.restaurant;
  EstablishmentTypes get establishmentType => _establishmentType;
  set establishmentType(EstablishmentTypes value) {
    _establishmentType = value;
    notifyListeners();
  }

//Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image?.deleteSync();
      // imagePath = pickedFile.path;
      image = File(pickedFile.path);
      saveChanges();

      notifyListeners();
    }
  }

//Image Picker function to get image from camera
  // Future getImageFromCamera() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.camera);

  //   if (pickedFile != null) {
  //     image = File(pickedFile.path);
  //     _imagePath = pickedFile.path;
  //     notifyListeners();
  //   }
  // }

  String? parsePathToName() {
    if (image != null) {
      final filename = image!.path.split("/").last;
      return filename;
    }
    return null;
  }

  void deleteOldImage() {
    if (image != null && image!.existsSync()) image?.deleteSync();
    image = null;
    saveChanges();
    notifyListeners();
  }

  void resetFields() {
    final establishment = settingsStore.state.establishment;
    if (establishment != null) {
      establishmentNameTextController.text = establishment.name;
      establishmentLocalTextController.text = establishment.location ?? "";
      if (establishment.imagePath != null) {
        image = File(establishment.imagePath!);
        establishmentImagePathTextController.text =
            establishment.imagePath ?? "";
      }
      _establishmentType = establishment.establishmentType;
    }
  }

  void saveChanges() {
    final settings = settingsStore.state.copyWith(
      establishment: settingsStore.state.establishment?.copyWith(
        name: establishmentNameTextController.text,
        establishmentType: establishmentType,
        imagePath: image != null && image!.existsSync() ? image?.path : null,
        location: establishmentLocalTextController.text,
      ),
    );
    settingsStore.saveSettings(settings);
  }

  @override
  void dispose() {
    establishmentNameTextController.dispose();
    establishmentLocalTextController.dispose();
    super.dispose();
  }
}
