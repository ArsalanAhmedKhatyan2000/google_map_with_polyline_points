import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.8569, 67.2647),
    zoom: 14.4746,
  );
  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(24.8509, 67.2706),
        infoWindow: InfoWindow(title: "Shah Latif Town")),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(24.8279, 67.2859),
        infoWindow: InfoWindow(title: "Cattle Colony")),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(24.8268, 67.2446),
        infoWindow: InfoWindow(title: "Export Processing Zone Authority")),
  ];
  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        compassEnabled: true,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(target: LatLng(24.8268, 67.2446), zoom: 14),
            ),
          );
        },
        child: const Icon(Icons.location_disabled_outlined),
      ),
    );
  }
}
