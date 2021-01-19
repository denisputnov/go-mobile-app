import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class MapsIcon extends StatefulWidget {
  @override
  _MapsIconState createState() => _MapsIconState();
}

class _MapsIconState extends State<MapsIcon> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<Uint8List> getFastFood() async {
    ByteData fastFoodIcon = await DefaultAssetBundle.of(context)
        .load("assets/icons/maps/location.png");
    return fastFoodIcon.buffer.asUint8List();
  }

  Future<Uint8List> getRestaurant() async {
    ByteData restaurantIcom = await DefaultAssetBundle.of(context)
        .load("assets/icons/maps/location.png");
    return restaurantIcom.buffer.asUint8List();
  }

  Future<Uint8List> getHotel() async {
    ByteData hotelIcon = await DefaultAssetBundle.of(context)
        .load("assets/icons/maps/location.png");
    return hotelIcon.buffer.asUint8List();
  }

  Future<Uint8List> getBank() async {
    ByteData bankIcon = await DefaultAssetBundle.of(context)
        .load("assets/icons/maps/location.png");
    return bankIcon.buffer.asUint8List();
  }

  Future<Uint8List> getSight() async {
    ByteData sightIcon = await DefaultAssetBundle.of(context)
        .load("assets/icons/maps/location.png");
    return sightIcon.buffer.asUint8List();
  }

  Future<Uint8List> getMuseum() async {
    ByteData museumIcon = await DefaultAssetBundle.of(context)
        .load("assets/icons/maps/location.png");
    return museumIcon.buffer.asUint8List();
  }

  Future<Uint8List> getPharmacy() async {
    ByteData pharmacyIcon = await DefaultAssetBundle.of(context)
        .load("assets/icons/maps/location.png");
    return pharmacyIcon.buffer.asUint8List();
  }

  Future<Uint8List> getHospital() async {
    ByteData hospitalIcon = await DefaultAssetBundle.of(context)
        .load("assets/icons/maps/location.png");
    return hospitalIcon.buffer.asUint8List();
  }

  Future<Uint8List> getMall() async {
    ByteData mallIcon = await DefaultAssetBundle.of(context)
        .load("assets/icons/maps/location.png");
    return mallIcon.buffer.asUint8List();
  }
}
