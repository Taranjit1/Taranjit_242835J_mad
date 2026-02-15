import 'package:flutter/material.dart';
import 'package:project/bike.dart';
import 'package:project/history.dart';
import 'package:project/map.dart';
import 'profile.dart';
import 'about.dart';
import 'user_data.dart';
import 'route.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  final String email;
  const HomePage({super.key, required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String currentUsername = "DefaultUser";
  String currentPhoto = "images/guest.png";
  late String currentPassword;
  Map<String, dynamic>? activeRoute;
  List<Map<String, dynamic>> routeHistory = [];

  @override
  void initState() {
    super.initState();
    currentPassword = registeredUsers
        .firstWhere(
          (user) => user.email == widget.email,
        )
        .password;
  }

  void _handleUsernameChange(String newName) {
    setState(() {
      currentUsername = newName;
    });
  }

  void _handlePhotoChange(String newPath) {
    setState(() {
      currentPhoto = newPath;
    });
  }

  void _handlePasswordChange(String newPassword) {
    setState(() {
      currentPassword = newPassword;
      var user = registeredUsers.firstWhere((u) => u.email == widget.email);

      int index = registeredUsers.indexOf(user);
      registeredUsers[index] =
          UserDetails(email: widget.email, password: newPassword);
    });
  }
  void _handleRouteSubmit(
      Map<String, dynamic> startLoc, Map<String, dynamic> endLoc) {
    setState(() {
      final newRoute = {
        'startName': startLoc['display_name'],
        'endName': endLoc['display_name'],
        'startCoord':
            LatLng(startLoc['lat'] as double, startLoc['lon'] as double),
        'endCoord': LatLng(endLoc['lat'] as double, endLoc['lon'] as double),
      };

      activeRoute = newRoute;
      routeHistory.insert(0, newRoute);
      _selectedIndex = 1;
    });
  }

  void _handleHistoryClick(Map<String, dynamic> savedRoute) {
    setState(() {
      activeRoute = savedRoute;
      _selectedIndex = 1;
    });
  }

  List<Widget> get _widgetOptions => <Widget>[
        RoutePage(onSubmit: _handleRouteSubmit),
        MapPage(routeData: activeRoute),
        const BikeMapPage(),
        HistoryPage(history: routeHistory, onRouteClicked: _handleHistoryClick),
        ProfilePage(
          emailid: widget.email,
          username: currentUsername,
          onUsernameChanged: _handleUsernameChange,
          photo: currentPhoto,
          onPhotoChanged: _handlePhotoChange,
          password: currentPassword,
          onPasswordChanged: _handlePasswordChange,
        ),
        const AboutPage(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Route'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.pedal_bike), label: 'Bikes'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Colors.green,
      ),
    );
  }
}
