import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  @override
  void initState() {
    super.initState();
    tetouan = new LatLng(35.57845, -5.36837);
    tetouanMarker =
        new Marker(markerId: MarkerId(tetouan.toString()), position: tetouan);
    markers = [tetouanMarker];
    _kStartingPosition = CameraPosition(
      target: tetouan,
      zoom: 14.4746,
    );
  }

  LatLng tetouan;
  Marker tetouanMarker;
  List<Marker> markers;
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kStartingPosition;

  _handleTap(LatLng marker) {
    setState(() {
      markers = [];
      markers.add(
          new Marker(markerId: MarkerId(marker.toString()), position: marker));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kStartingPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(markers),
        onTap: _handleTap,
      ),
    );
  }
}
