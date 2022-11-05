import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMapShow extends StatefulWidget {
  const GoogleMapShow({Key? key}) : super(key: key);

  @override
  State<GoogleMapShow> createState() => _GoogleMapShowState();
}

class _GoogleMapShowState extends State<GoogleMapShow> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
      GoogleMap(
        initialCameraPosition: _kGooglePlex, // 초기 카메라 위치
        onMapCreated: (GoogleMapController controller) async{
          _controller.complete(controller);
        },
      ),
    );
  }
}
