import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  final Map<String, dynamic>? routeData;
  const MapPage({super.key, this.routeData});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LatLng _singaporeCenter = const LatLng(1.3521, 103.8198);

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [];
    List<Polyline> polylines = [];

    if (widget.routeData != null) {
      final LatLng start = widget.routeData!['startCoord'];
      final LatLng end = widget.routeData!['endCoord'];

      markers.add(
        Marker(
          point: start,
          width: 40,
          height: 40,
          child: const Icon(Icons.location_on, color: Colors.green, size: 40),
        ),
      );

      markers.add(
        Marker(
          point: end,
          width: 40,
          height: 40,
          child: const Icon(Icons.flag, color: Colors.red, size: 40),
        ),
      );

      polylines.add(
        Polyline(
          points: [start, end],
          strokeWidth: 4.0,
          color: Colors.blue,
        ),
      );
    }

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
          initialCenter: widget.routeData != null
              ? widget.routeData!['startCoord']
              : _singaporeCenter,
          initialZoom: 11.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.sgnav',
          ),
          PolylineLayer(polylines: polylines),
          MarkerLayer(markers: markers),
        ],
      ),
    );
  }
}
