import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math';

class BikeMapPage extends StatefulWidget {
  const BikeMapPage({super.key});

  @override
  State<BikeMapPage> createState() => _BikeMapPageState();
}

class _BikeMapPageState extends State<BikeMapPage> {
  final LatLng _singaporeCenter = const LatLng(1.3521, 103.8198);
  final List<Marker> _bikeMarkers = [];

  @override
  void initState() {
    super.initState();
    _generateRandomBikes();
  }

  void _generateRandomBikes() {
    final Random random = Random();

    for (int i = 0; i < 50; i++) {
      double latOffset = (random.nextDouble() - 0.5) * 0.15;
      double lngOffset = (random.nextDouble() - 0.5) * 0.25;

      _bikeMarkers.add(
        Marker(
          point: LatLng(
            _singaporeCenter.latitude + latOffset,
            _singaporeCenter.longitude + lngOffset,
          ),
          width: 40,
          height: 40,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        "Bike #$i selected! Battery: ${random.nextInt(100)}%")),
              );
            },
            child: const Icon(
              Icons.pedal_bike,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.green,
            width: 3,
          ),
        ),
        title: Center(
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,
            height: 35,
          ),
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _singaporeCenter,
          initialZoom: 11.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.project.sgnav',
          ),
          MarkerLayer(markers: _bikeMarkers),
        ],
      ),
    );
  }
}
