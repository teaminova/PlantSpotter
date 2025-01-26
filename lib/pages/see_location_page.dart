import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class SeeLocationPage extends StatelessWidget {
  final LatLng location;

  const SeeLocationPage({required this.location, Key? key}) : super(key: key);

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
          initialCenter: location,
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
                point: location,
                width: 100,
                height: 100,
                child: GestureDetector(
                  onTap: () {
                    // context.pop();
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
}
