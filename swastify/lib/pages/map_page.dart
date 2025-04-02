import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:swastify/components/app_bar.dart';
import 'package:swastify/components/sidebar.dart';
import 'package:swastify/config/env.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  static const LatLng _pApplePark = LatLng(37.3346, -122.0090);
  LatLng? _currentP = null;
  bool _isUserInteracting = false;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
    // getLocationUpdates().then(
    //   (_) => {
    //     getPolyLinePoints().then(
    //       (coordinates) => {generatePolyLineFromPoints(coordinates)},
    //     ),
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: "Maps"),
      drawer: SideBar(selectedIndex: 3),

      body: Stack(
        children: [
          _currentP == null
              ? const Center(child: Text("Loading..."))
              : GoogleMap(
                onMapCreated:
                    ((GoogleMapController controller) =>
                        _mapController.complete(controller)),
                initialCameraPosition: CameraPosition(
                  target: _currentP!,
                  // zoom: 13,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId("_currentLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _currentP!,
                  ),
                  // Marker(
                  //   markerId: MarkerId("_sourceLocation"),
                  //   icon: BitmapDescriptor.defaultMarker,
                  //   position: _pGooglePlex,
                  // ),
                  // Marker(
                  //   markerId: MarkerId("_destinationLocation"),
                  //   icon: BitmapDescriptor.defaultMarker,
                  //   position: _pApplePark,
                  // ),
                },
                polylines: Set<Polyline>.of(polylines.values),
                onCameraMoveStarted: () {
                  print("User started dragging the map");
                  setState(() {
                    _isUserInteracting = true;
                  });
                },
                onCameraIdle: () {
                  print("User stopped dragging the map");
                  // setState(() {
                  //   _isUserInteracting = false;
                  // });
                },
              ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isUserInteracting = false;
                });
                getLocationUpdates();
              },
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _targetToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos);

    print("target camera");
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    print("camera focus");
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    print("getLocationUpdates Called");
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((
      LocationData currentLocation,
    ) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
          if (_isUserInteracting) {
            _targetToPosition(_currentP!);
          } else {
            _cameraToPosition(_currentP!);
          }
        });
      }
    });
  }

  Future<List<LatLng>> getPolyLinePoints() async {
    List<LatLng> polyLineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: GOOGLE_MAP_API_KEY,
      request: PolylineRequest(
        origin: PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
        destination: PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    return polyLineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 8,
    );

    setState(() {
      polylines[id] = polyline;
    });
  }
}
