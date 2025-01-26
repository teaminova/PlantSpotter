import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImageService with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  XFile? get selectedImage => _selectedImage;

  Future<String?> takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        _selectedImage = photo;
        notifyListeners();
      }
      return photo?.path;
    } catch (e) {
      print('Error taking photo: $e');
    }
    return null;
  }

  Future<String?> pickFromGallery() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
      if (photo != null) {
        _selectedImage = photo;
        notifyListeners();
      }
      return photo?.path;
    } catch (e) {
      print('Error picking photo: $e');
    }
    return null;
  }

  List<String> getGalleryImages() {
    return [
      'assets/rose.png',
      'assets/tulip.png',
      'assets/sunflower.png',
      'assets/daffodil.png',
      'assets/orchid.png',
      'assets/oak.png',
      'assets/holly.png',
      'assets/dahlia.png',
    ];
  }

  // Future<File?> pickImageFromGallery() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   return image != null ? File(image.path) : null;
  // }
  //
  // Future<File?> captureImageFromCamera() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  //   return image != null ? File(image.path) : null;
  // }
}
