import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/wiki_service.dart';
import '../widgets/wiki_card.dart';

class LearnMorePage extends StatelessWidget {
  final String plantName;

  const LearnMorePage({required this.plantName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
        title: const Text('Learn More', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: WikiService().fetchPlantInfo(plantName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final description = snapshot.data?['description'] ?? 'No information available.';
            final imageUrl = snapshot.data?['imageUrl'] ?? '';

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (imageUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        width: 350,
                        height: 350,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(plantName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF6B8E58))),
                  const SizedBox(height: 8),
                  WikiCard(
                    info: description,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
