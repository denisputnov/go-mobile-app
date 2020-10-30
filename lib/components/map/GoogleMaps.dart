import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMaps createState() => _GoogleMaps();
}

class _GoogleMaps extends State<GoogleMaps> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      onTap: (none) {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      mapType: MapType.normal,
      initialCameraPosition:
          CameraPosition(target: LatLng(51.719166, 39.182728), zoom: 15),
    );
  }
}
