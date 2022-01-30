import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'dart:ui' as ui;

import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/constance/constance.dart';
import 'package:inbox_driver/util/location_helper.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:logger/logger.dart';

class MapViewModel extends GetxController {
  Completer<GoogleMapController>? controller = Completer();
  GoogleMapController? mapController;

  CameraPosition initialCameraPosition = const CameraPosition(
  target: LatLng(25.320004788193835, 51.189434716459175),
  zoom: 14.4746,
  tilt: 59.440717697143555,
  );

  Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = Set()
    ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
    ..add(
      Factory<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer()),
    )
    ..add(
      Factory<HorizontalDragGestureRecognizer>(
          () => HorizontalDragGestureRecognizer()),
    )
    ..add(
      Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
    );

  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};

  LatLng myLatLng = const LatLng(25.320004788193835, 51.189434716459175);
  LatLng customerLatLng = const LatLng(25.320004788193835, 51.189434716459175);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    controller = null;
  }

  @override
  void onReady() {
    super.onReady();
  }

  // Future<void> goToTheLake() async {
  //   final GoogleMapController controllers = await controller!.future;
  //   controllers.animateCamera(CameraUpdate.newCameraPosition(myLatLng));
  // }

  onMapCreated(GoogleMapController controllerMap) async {
    if (!controller!.isCompleted) {
      controller?.complete(controllerMap);
    }
    mapController = controllerMap;
    //todo here we use two method first for me and another for the user
    //todo me = driver
    await getMyCurrentPosition();
    getMyCurrentMarkers();
    getUserMarkers();
    Future.delayed(const Duration(seconds: 0)).then((value) async {
      await foucCameraOnUsers(
          /*controllerMap*/
          mapController!,
          myLatLng,
          customerLatLng);
    });
  }

  onMapTaped(LatLng argument) {}

  Future<BitmapDescriptor> _getMarkerImageFromUrl(String url, {int? targetWidth, Color? color}) async {
    final File markerImageFile = await DefaultCacheManager().getSingleFile(url);
    if (targetWidth != null) {
      return _convertImageFileToBitmapDescriptor(markerImageFile,
          size: targetWidth, titleColor: color!);
    } else {
      Uint8List markerImageBytes = await markerImageFile.readAsBytes();
      return BitmapDescriptor.fromBytes(markerImageBytes);
    }
  }

  Future<BitmapDescriptor> _convertImageFileToBitmapDescriptor(File imageFile,{int size = 100, bool addBorder = false, Color borderColor = Colors.white, double borderSize = 10, Color titleColor = Colors.transparent, Color titleBackgroundColor = Colors.transparent}) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color;
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    final double radius = size / 2;

    //make canvas clip path to prevent image drawing over the circle
    final Path clipPath = Path();
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        const Radius.circular(100)));
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(size / 2.toDouble(), size + 20.toDouble(), 10, 10),
        const Radius.circular(100)));
    clipPath.quadraticBezierTo(50, 200, 100, 0);
    canvas.clipPath(clipPath);
    canvas.drawColor(titleColor, BlendMode.dstOver);
    // canvas.drawPaint(paint);

    //paintImage
    final Uint8List imageUint8List = await imageFile.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(imageUint8List);
    final ui.FrameInfo imageFI = await codec.getNextFrame();
    paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        image: imageFI.image);

    //convert canvas as PNG bytes
    final _image = await pictureRecorder
        .endRecording()
        .toImage(size, (size * 1.1).toInt());
    final data = await _image.toByteData(format: ui.ImageByteFormat.png);

    //convert PNG bytes as BitmapDescriptor
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  getMyCurrentMarkers() async {
    // markers.clear();
    final Marker marker = Marker(
      markerId: const MarkerId("{e.id.toString()}"),
      icon: await _getMarkerImageFromUrl("${SharedPref.instance.getCurrentUserData()?.image ?? "https://scontent.fjrs2-2.fna.fbcdn.net/v/t39.30808-6/258867044_1337774763328553_6721770954985841116_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=HRPRVV5a1Q0AX_AqbjN&_nc_ht=scontent.fjrs2-2.fna&oh=00_AT_lk4raRmMFBvU74Dp4FZ9bySLd2ZCfr__aCUbNlWbrIw&oe=61F286A2"}",
          targetWidth: 180,
          color: colorTrans),
      position: myLatLng,
      infoWindow: InfoWindow(title: "Osama"  ,/*anchor:const  Offset(1.0, 0.7),*/onTap: () {
        Logger().d("");
      },) ,
      // onTap: () {
      //
      // },
    );
    markers.add(marker);
    update();
  }

  getUserMarkers() async {
    // markers.clear();

    final Marker marker = Marker(
      markerId: const MarkerId("{e.id.toString()س}"),
      icon: await _getMarkerImageFromUrl(
          "https://scontent.fjrs2-2.fna.fbcdn.net/v/t1.6435-9/159622889_1167941780311853_4697952185015179188_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=174925&_nc_ohc=oY6Z0ijF12gAX-1BfZL&_nc_ht=scontent.fjrs2-2.fna&oh=00_AT8TzHQ2hjLTV7thzU8g3aNifCmySibPkY6Y9PVA3aY6tw&oe=62139BC9",
          targetWidth: 180,
          color: colorTrans),
      position: customerLatLng,
      infoWindow: InfoWindow(title: "Osama"  /*,anchor:const  Offset(1.0, 1.0)*/,onTap: () {
        Logger().d("");
      },) ,
      // onTap: () {
      // },
    );
    markers.add(marker);
    update();
  }

  foucCameraOnUsers(GoogleMapController mapController, LatLng pickUp, LatLng destination) async {
    //todo this for make map camera fouc on the to marker in the map
    await addLinesToMap(pickUp, destination);
    LatLngBounds bounds;
    if (pickUp.latitude > destination.latitude &&
        pickUp.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, destination.longitude),
          northeast: LatLng(pickUp.latitude, pickUp.longitude));
    } else if (pickUp.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(pickUp.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, pickUp.longitude));
    } else if (pickUp.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, pickUp.longitude),
          northeast: LatLng(pickUp.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(
          southwest: LatLng(pickUp.latitude, pickUp.longitude),
          northeast: LatLng(destination.latitude, destination.longitude));
    }
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));
    update();
  }

  addLinesToMap(LatLng pickUp, LatLng destination) async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> listPoints = <LatLng>[];


    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
            ConstanceApp.googleMapKey.toString(),
            PointLatLng(pickUp.latitude, pickUp.longitude),
            PointLatLng(destination.latitude, pickUp.longitude),
            travelMode: TravelMode.driving,
          );

      var status = result.status;
      var errorMessage = result.errorMessage;
      Logger().d("$status $errorMessage");
      if(result.status?.toLowerCase() == "ok" ){
            if (result.points.isNotEmpty) {
              for (var point in result.points) {
                Logger().d("listPoints_${point.latitude}");
                listPoints.add(LatLng(point.latitude, point.longitude));
              }
            }
          }
    } catch (e) {
      Logger().d(e);
    }


    Polyline polyline = Polyline(
        polylineId: const PolylineId("poly"),
        points: listPoints,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        width: 4,
        geodesic: true,
        jointType: JointType.round);
    polyLines.add(polyline);
    update();
  }


  getMyCurrentPosition()async{
    await LocationHelper.instance.getCurrentPosition().then((Position value) {
      myLatLng = LatLng(value.latitude, value.longitude);
      //if we need we can make animate for camera
      update();
    });
  }
}