import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<LatLng?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null; // Location services are not enabled
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null; // Permissions are denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null; // Permissions are permanently denied
    }

    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }
}
