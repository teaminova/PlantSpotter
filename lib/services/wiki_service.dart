// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class WikiService {
//   // Future<Map<String, dynamic>?> fetchPlantInfo(String plantName) async {
//   //   final Uri url = Uri.parse(
//   //       'https://en.wikipedia.org/w/api.php?action=query&prop=extracts|pageimages&format=json&exintro=&titles=$plantName');
//   //
//   //   try {
//   //     final response = await http.get(url);
//   //     if (response.statusCode == 200) {
//   //       final Map<String, dynamic> data = json.decode(response.body);
//   //       return data;
//   //     }
//   //   } catch (e) {
//   //     print('Error fetching plant info: $e');
//   //   }
//   //   return null;
//   // }
//
//   Future<String> getPlantInfo(String query) async {
//     final url = Uri.parse('https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&exintro&explaintext&titles=$query');
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final pages = data['query']['pages'];
//       final page = pages.values.first;
//       return page['extract'] ?? 'No information available.';
//     } else {
//       throw Exception('Failed to load Wikipedia data');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;

class WikiService {
  // Fetch plant info including description and main image URL
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
