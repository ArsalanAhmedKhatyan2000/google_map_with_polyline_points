import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Set<Polyline> polylines = {};

  List<LatLng> polylineCoordinates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map with Drawing')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(0.0, 0.0), // Set initial map center
          zoom: 15.0, // Adjust the initial zoom level
        ),
        polylines: polylines,
        onTap: _addPointToPolyline,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Retrieve the list of coordinates when the FAB is pressed
          print(polylineCoordinates);
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _addPointToPolyline(LatLng point) {
    setState(() {
      polylineCoordinates.add(point);

      // Create a polyline with the updated coordinates
      Polyline polyline = Polyline(
        polylineId: PolylineId(DateTime.now().toString()),
        color: Colors.blue,
        points: polylineCoordinates,
        width: 5,
      );

      // Update the set of polylines on the map
      polylines.add(polyline);
    });
  }
}

// void main() => runApp(MaterialApp(
//       home: MapScreen(),
//     ));
