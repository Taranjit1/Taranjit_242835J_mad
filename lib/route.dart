import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class RoutePage extends StatefulWidget {
  final Function(Map<String, dynamic>, Map<String, dynamic>) onSubmit;
  const RoutePage({super.key, required this.onSubmit});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final List<Map<String, dynamic>> _presetLocations = [
    {'name': 'Marina Bay Sands', 'coords': const LatLng(1.2823, 103.8585)},
    {
      'name': 'National University of Singapore (NUS)',
      'coords': const LatLng(1.2966, 103.7764)
    },
    {'name': 'Changi Airport', 'coords': const LatLng(1.3644, 103.9915)},
    {'name': 'Singapore Zoo', 'coords': const LatLng(1.4043, 103.7930)},
    {'name': 'VivoCity', 'coords': const LatLng(1.2642, 103.8223)},
  ];

  Map<String, dynamic>? _selectedStart;
  Map<String, dynamic>? _selectedEnd;

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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.map_outlined, size: 80, color: Colors.green),
            const SizedBox(height: 30),
            DropdownButtonFormField<Map<String, dynamic>>(
              decoration: const InputDecoration(
                labelText: "Start Location",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.my_location),
              ),
              value: _selectedStart,
              items: _presetLocations.map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location['name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStart = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<Map<String, dynamic>>(
              decoration: const InputDecoration(
                labelText: "Destination",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.flag),
              ),
              value: _selectedEnd,
              items: _presetLocations.map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location['name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedEnd = value;
                });
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  if (_selectedStart != null && _selectedEnd != null) {
                    if (_selectedStart == _selectedEnd) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Start and Destination cannot be the same!")),
                      );
                      return;
                    }

                    final startData = {
                      'display_name': _selectedStart!['name'],
                      'lat': _selectedStart!['coords'].latitude,
                      'lon': _selectedStart!['coords'].longitude,
                    };

                    final endData = {
                      'display_name': _selectedEnd!['name'],
                      'lat': _selectedEnd!['coords'].latitude,
                      'lon': _selectedEnd!['coords'].longitude,
                    };

                    widget.onSubmit(startData, endData);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please select both locations")),
                    );
                  }
                },
                child: const Text(
                  "FIND ROUTE",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
