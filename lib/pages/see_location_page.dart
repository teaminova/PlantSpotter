import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../utils/google_maps.dart';

class SeeLocationPage extends StatefulWidget {
  final LatLng location;

  const SeeLocationPage({required this.location, Key? key}) : super(key: key);

  @override
  State<SeeLocationPage> createState() => _SeeLocationPageState();
}

class _SeeLocationPageState extends State<SeeLocationPage> {

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
        title: const Text('Location', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: widget.location,
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: widget.location,
                width: 100,
                height: 100,
                child: GestureDetector(
                  onTap: () {
                    _showAlertDialog();
                  },
                  child: const Icon(Icons.location_on, color: Colors.red, size: 36),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Redirect to Google Maps?'),
          content: const Text('Do you want to open Google Maps to see the route to this entry location?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                GoogleMaps.openGoogleMaps(widget.location.latitude, widget.location.longitude);
                Navigator.of(context).pop();
              },
              child: const Text('Open'),
            ),
          ],
        );
      },
    );
  }
}
