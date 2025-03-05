import 'dart:convert';
import 'package:http/http.dart' as http;

class WikiService {
  // Fetch plant info: description and image URL
  Future<Map<String, dynamic>> fetchPlantInfo(String query) async {
    final url = Uri.parse(
        'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts|pageimages&exintro&explaintext&titles=$query&piprop=original');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final pages = data['query']['pages'];
        final page = pages.values.first;

        // Extract the plant description (if available)
        final description = page['extract'] ?? 'No information available.';

        // Extract the main image URL (if available)
        final imageUrl = page['original']?['source'] ?? '';

        return {'description': description, 'imageUrl': imageUrl};
      }
    } catch (e) {
      print('Error fetching plant info: $e');
    }
    return {'description': 'Error fetching data', 'imageUrl': ''};
  }
}
