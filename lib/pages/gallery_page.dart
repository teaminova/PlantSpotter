import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../services/image_service.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final images = ImageService().getGalleryImages();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            context.pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF6B8E58),
          ),
        ),
        title: const Text('Gallery', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: images.length, // Placeholder number
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => context.pop(),
            child:
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                images[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
