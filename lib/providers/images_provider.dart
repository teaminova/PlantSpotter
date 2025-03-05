import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImagesProvider extends ChangeNotifier {
  File? _img = null;

  File? get image => _img;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try{
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _img = File(pickedFile.path);
        print(_img!.path);
        notifyListeners();
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    try {
      final photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        _img = File(photo.path);
        print(_img!.path);
        notifyListeners();
      } else {
        print('No image taken.');
      }
    } catch (e) {
      print('Error taking photo: $e');
    }
  }

  Future<String?> uploadImage() async {
    if (_img == null) {
      return null;
    }
    notifyListeners();
    try {
      String fileName = path.basename(_img!.path);
      Reference storageRef = FirebaseStorage.instance.ref().child('plantImages/$fileName');
      await storageRef.putFile(_img!);
      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
    } finally {
      notifyListeners();
    }
    return null;
  }

  void removeImage() {
    _img = null;
  }

}
