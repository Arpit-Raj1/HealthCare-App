import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";
import 'package:http/http.dart' as http;
import 'package:swastify/components/app_bar.dart';
import 'package:swastify/components/search_bar.dart';
import 'package:swastify/components/sidebar.dart';

void main() {
  runApp(
    const MaterialApp(home: MapsPage(), debugShowCheckedModeBanner: false),
  );
}

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State createState() => _MapsPageState();
}

class _MapsPageState extends State {
  late GoogleMapController mapController;

  final LatLng _center = LatLng(25.5356448, 84.8512966);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final TextEditingController _searchController = TextEditingController();

  Future<List<Marker>> fetchNearbyPlaces(String type) async {
    const apiKey = 'AIzaSyAq_OH_2Fx_p4KUJTUox5hbJeoWSjhc6hY';
    final location = '${_center.latitude},${_center.longitude}';
    final radius = 5000; // in meters

    final url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${location}&radius=${radius}&type=${type}&key=${apiKey}";

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data['status'] != 'OK') {
      print("Error: ${data['status']}");
      return [];
    }

    List results = data['results'];

    return results.map<Marker>((place) {
      final lat = place['geometry']['location']['lat'];
      final lng = place['geometry']['location']['lng'];
      final name = place['name'];

      return Marker(
        markerId: MarkerId(name),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: name),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          type == 'hospital'
              ? BitmapDescriptor.hueRed
              : BitmapDescriptor.hueBlue,
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const Drawer(),
      appBar: Appbar(title: "Maps"),
      drawer: SideBar(selectedIndex: 3),
      body: Column(
        children: [
          CustomSearchBar(onChanged: (value) {}, controller: _searchController),
          const SizedBox(height: 8),

          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                markers: {
                  Marker(markerId: const MarkerId('1'), position: _center),
                },
                myLocationEnabled: true,
                zoomControlsEnabled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
