import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:plant_spotter_lab2/services/location_service.dart';

class SetLocationPage extends StatefulWidget {
  @override
  _SetLocationPageState createState() => _SetLocationPageState();
}

class _SetLocationPageState extends State<SetLocationPage> {
  LatLng? _markerPosition = LatLng(42.004971, 21.408303);
  LatLng _initialCenter = LatLng(42.004971, 21.408303);
  bool _isLoading = true;
  bool _locationError = false;

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    LatLng? currentLocation = await LocationService().getCurrentLocation();
    if (currentLocation != null) {
      setState(() {
        _initialCenter = currentLocation;
        _markerPosition = currentLocation;
      });
    } else {
      setState(() => _locationError = true);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_locationError)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 10),
                  const Text("Unable to get location.\nMake sure GPS is enabled."),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _fetchCurrentLocation,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            )
          else
            FlutterMap(
              options: MapOptions(
                initialCenter: _initialCenter,
                initialZoom: 13.0,
                onTap: (_, LatLng position) {
                  // Place a pin on normal tap
                  setState(() {
                    _markerPosition = position;
                  });
                },
                onLongPress: (_, LatLng position) {
                  // Place a pin on double tap
                  setState(() {
                    _markerPosition = position;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                if (_markerPosition != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _markerPosition!,
                        width: 100,
                        height: 100,
                        child: const Icon(Icons.location_on, color: Colors.red, size: 36),
                      ),
                    ],
                  ),
              ],
            ),
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Color(0xFF6B8E58)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Click on the map to place a pin on your desired location.',
                        style: TextStyle(
                          color: Color(0xFF6B8E58),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 100,
            right: 100,
            child: SizedBox(
              width: 200,
              child: TextButton(
                onPressed: () {
                  if (_markerPosition != null) {
                    context.pop(_markerPosition);
                  } else {
                    context.pop();
                  }
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Done'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
