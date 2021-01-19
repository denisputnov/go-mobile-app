import 'package:flutter/material.dart';
import 'package:go/components/map/Filter.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:go/utils/default.dart';

import '../components/map/Search.dart';

import 'package:go/utils/variables/filter.dart' as filter;

import 'package:go/utils/default.dart';

class MapWidget extends StatefulWidget {
  final label;

  MapWidget({this.label});

  @override
  _MapWidgetState createState() => _MapWidgetState(label: label);
}

class _MapWidgetState extends State<MapWidget>
    with SingleTickerProviderStateMixin {
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
  AnimationController _controller;
  Duration _duration = Duration(milliseconds: 600);
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  var myLocation = Location().getLocation();
  Iterable placeMarkers = [];
  Iterable finalMarkers = [];
  Marker marker;
  GoogleMapController __controller;
  bool isPressed = false;
  final label;
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(51.1413650, 39.4217033),
    zoom: 15,
  );
  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("assets/icons/maps/location.png");
    return byteData.buffer.asUint8List();
  }

  Future<Uint8List> getRestaurantMarker() async {
    ByteData restaurantIcom = await DefaultAssetBundle.of(context)
        .load("assets/icons/maps/location.png");
    return restaurantIcom.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    if (filter.restaurant) {}
    this.setState(() {
      marker = Marker(
        markerId: MarkerId("me"),
        position: latlng,
        rotation: newLocalData.heading,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData),
      );
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      if (_controller != null) {
        __controller.animateCamera(
          CameraUpdate.newCameraPosition(
            new CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(location.latitude, location.longitude),
                tilt: 0,
                zoom: 15),
          ),
        );
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  _MapWidgetState({this.label});

  // Анимация фильтра и убирание кнопки
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _controller.addStatusListener((status) {
      if (!(status.index == 1 || status.index == 2)) setNewButtonState();
    });
  }

  // Берем инфу по данным рядом с положением человека и находим места рядом
  /* getPlaceData() async {
    if (filter.pharmacy) {
      Uint8List placesimageData = await getRestaurantMarker();
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");

      try {
        final response = await http.get(
            'https://maps.googleapis.com/maps/api/place/textsearch/?query=restaurants%in%Voronezh&key=AIzaSyDRS1a1e8lnlyHbjdz8iQHBRiRW4qNg_QA');

        final int statusCode = response.statusCode;

        if (statusCode == 201 || statusCode == 200) {
          Map responseBody = json.decode(response.body);
          List results = responseBody["results"];
          print(results.length);

          Iterable _placeMarkers = Iterable.generate(results.length, (index) {
            Map result = results[index];
            Map location = result["geometry"]["location"];
            LatLng latLngMarker = LatLng(location["lat"], location["lng"]);

            return Marker(
              markerId: MarkerId("marker$index"),
              position: latLngMarker,
              icon: BitmapDescriptor.fromBytes(placesimageData),
            );
          });

          setState(() {
            placeMarkers = _placeMarkers;
          });
        } else {
          throw Exception('Error');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  } */

  // Удаляем кнопку
  void setNewButtonState() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  // Объединяем маркеры мест с маркерами локации
  Iterable mergeMarkers() {
    finalMarkers = placeMarkers;
    if (finalMarkers.length == 0) {
      finalMarkers = [];
    }
    return finalMarkers;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Default.getDefaultBackgroundColor(),
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                compassEnabled: false,
                zoomControlsEnabled: false,
                onTap: (none) {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                mapType: MapType.normal,
                initialCameraPosition: initialLocation,
                markers: (filter.pharmacy
                    ? Set.from(mergeMarkers())
                    : Set.of((marker != null) ? [marker] : [])),
                onMapCreated: (GoogleMapController controller) {
                  __controller = controller;
                },
              ),
              Positioned(
                child: Container(
                  height: MediaQuery.of(context).size.width / 7.5,
                  child: AppBar(
                    leading: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Default.getDefaultBackgroundColor(),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: Search(),
                  ),
                ),
              ),
              Stack(
                children: [
                  SlideTransition(
                    position: _tween.animate(_controller),
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.8,
                      maxChildSize: 0.8,
                      minChildSize: 0.8,
                      builder: (context, ScrollController scrollController) {
                        return Container(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 25,
                              MediaQuery.of(context).size.width / 40,
                              MediaQuery.of(context).size.width / 40,
                              MediaQuery.of(context).size.width / 5),
                          child: Stack(
                            children: [
                              Filter(),
                            ],
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(0xff212121),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                child: Positioned(
                  bottom: MediaQuery.of(context).size.width / 20,
                  right: MediaQuery.of(context).size.width / 20,
                  child: Column(
                    children: [
                      !isPressed
                          ? FloatingActionButton(
                              heroTag: null,
                              backgroundColor: Default.getDefaultIconColor(),
                              child: Icon(Icons.location_searching),
                              onPressed: () {
                                getCurrentLocation();
                              },
                            )
                          : SizedBox(),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 30,
                      ),
                      FloatingActionButton(
                        heroTag: null,
                        child: AnimatedIcon(
                            icon: AnimatedIcons.menu_close,
                            progress: _controller),
                        elevation: 5,
                        backgroundColor: Default.getDefaultIconColor(),
                        foregroundColor: Colors.white,
                        onPressed: () async {
                          if (_controller.isDismissed) {
                            _controller.forward();
                          } else if (_controller.isCompleted) {
                            _controller.reverse();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
