import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../services/wiki_service.dart';

class LearnMorePage extends StatelessWidget {
  final String plantName;

  const LearnMorePage({required this.plantName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final String wikiUrl = 'https://en.wikipedia.org/wiki/$plantName';

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
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'From Wikipedia',
                            style: const TextStyle(
                              color: Color(0xFF6B8E58),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              description,
                              style: const TextStyle(
                                color: Color(0xFF6B8E58),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          if (description.isEmpty)
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'No information available.',
                                style: const TextStyle(
                                  color: Color(0xFF6B8E58),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      // WebView(
      //   initialUrl: wikiUrl,
      //   javascriptMode: JavascriptMode.unrestricted,
      // ),
    );
  }
}
