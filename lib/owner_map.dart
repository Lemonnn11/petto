import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OwnerMap extends StatefulWidget {
  String? name;
  OwnerMap({required this.name});
  @override
  State<OwnerMap> createState() => _OwnerMapState();
}

class _OwnerMapState extends State<OwnerMap> {
  Completer<GoogleMapController> _controller = Completer();

  static final Marker posMarker = Marker(
    markerId: MarkerId('posMarker'),
    infoWindow: InfoWindow(title: 'Pet\'s Location'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    position: LatLng(13.794516842371053, 100.32609946658924),
  );

  static final CameraPosition pos = CameraPosition(
      target: LatLng(13.794516842371053, 100.32609946658924), zoom: 4.4746);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: {posMarker},
        initialCameraPosition: pos,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
