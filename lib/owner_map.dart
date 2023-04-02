import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'constants.dart';

class OwnerMap extends StatefulWidget {
  String? name;
  OwnerMap({required this.name});
  @override
  State<OwnerMap> createState() => _OwnerMapState();
}

class _OwnerMapState extends State<OwnerMap> {
  GoogleMapController? _controller;

  static final Marker posMarker = Marker(
    markerId: MarkerId('posMarker'),
    infoWindow: InfoWindow(title: 'Pet\'s Location'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    position: LatLng(13.90431, 100.52807),
  );

  static final CameraPosition pos = CameraPosition(
    target: LatLng(13.90431, 100.52807),
    zoom: 14.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            markers: {posMarker},
            initialCameraPosition: pos,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          ),
          Positioned(
            top: 50,
            left: 30,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 18,
                          color: Colors.white,
                        ),
                        backgroundColor: kPurpleColor,
                        radius: 19,
                      ),
                    ),
                    Text(
                      'Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/pup.png'),
                      backgroundColor: Colors.grey[300],
                      radius: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 60.0,
            right: 30.0,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              onPressed: () {
                _controller!.animateCamera(CameraUpdate.zoomIn());
              },
              child: Icon(Icons.add),
            ),
          ),
          Positioned(
            bottom: 1.0,
            right: 120.0,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              onPressed: () {
                _controller!.animateCamera(CameraUpdate.zoomOut());
              },
              child: Icon(Icons.remove),
            ),
          ),
          Positioned(
            bottom: 1.0,
            left: 0.0,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              onPressed: () {
                _controller!.animateCamera(
                  CameraUpdate.newCameraPosition(pos),
                );
              },
              child: Icon(Icons.center_focus_strong),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
