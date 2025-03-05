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
      // await FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadUrl);
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


// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImagesProvider with ChangeNotifier {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _selectedImage;
//
//   XFile? get selectedImage => _selectedImage;
//
//   Future<String?> takePhoto() async {
//     try {
//       final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//       if (photo != null) {
//         _selectedImage = photo;
//         notifyListeners();
//       }
//       return photo?.path;
//     } catch (e) {
//       print('Error taking photo: $e');
//     }
//     return null;
//   }
//
//   Future<String?> pickFromGallery() async {
//     try {
//       final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
//       if (photo != null) {
//         _selectedImage = photo;
//         notifyListeners();
//       }
//       return photo?.path;
//     } catch (e) {
//       print('Error picking photo: $e');
//     }
//     return null;
//   }
//
//   List<String> getGalleryImages() {
//     return [
//       'assets/rose.png',
//       'assets/tulip.png',
//       'assets/sunflower.png',
//       'assets/daffodil.png',
//       'assets/orchid.png',
//       'assets/oak.png',
//       'assets/holly.png',
//       'assets/dahlia.png',
//     ];
//   }
//
//   // Future<File?> pickImageFromGallery() async {
//   //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//   //   return image != null ? File(image.path) : null;
//   // }
//   //
//   // Future<File?> captureImageFromCamera() async {
//   //   final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//   //   return image != null ? File(image.path) : null;
//   // }
// }
