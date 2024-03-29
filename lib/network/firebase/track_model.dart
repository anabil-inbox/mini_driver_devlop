// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inbox_driver/feature/model/driver_modle.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';

class TrackModel {

  TrackModel({this.serialOrderData, this.serialOrderDriverData, this.serialOrderDriverLocation});

  SalesOrder? serialOrderData;
  Driver? serialOrderDriverData;
  LatLng ?serialOrderDriverLocation;

  factory TrackModel.fromJson(Map<String, dynamic> json)=> TrackModel(
        serialOrderData:json["serialOrderData"] == null ? null:SalesOrder.fromJson(jsonDecode(json["serialOrderData"])),
        serialOrderDriverData:json["serialOrderDriverData"] == null ? null:Driver.fromJson(jsonDecode(json["serialOrderDriverData"])),
        serialOrderDriverLocation:json["serialOrderDriverLocation"] == null ? null:LatLng.fromJson(json["serialOrderDriverLocation"]),);

  Map<String, dynamic> toJson() =>{
    "serialOrderData": serialOrderData == null ?null :serialOrderData?.toJson(),
        "serialOrderDriverData":serialOrderDriverData == null ?null :serialOrderDriverData?.toJson(),
        "serialOrderDriverLocation":serialOrderDriverLocation == null ?null :serialOrderDriverLocation?.toJson(),
  };
}
