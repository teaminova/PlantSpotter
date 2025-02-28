import 'package:latlong2/latlong.dart';

class PlantEntry {
  final String image;
  final String name;
  final DateTime date;
  final LatLng location;
  final String description;
  final bool isPublic;
  final String user;

  PlantEntry({
    required this.image,
    required this.name,
    required this.date,
    required this.location,
    required this.description,
    required this.isPublic,
    required this.user,
  });
}