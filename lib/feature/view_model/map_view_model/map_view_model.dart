import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/sh_util.dart';

class MapViewModel extends GetxController {
  Completer<GoogleMapController>? controller;

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(31.523769049641757, 34.44088739998413),
    zoom: 14.4746,
  );

  CameraPosition kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(31.523769049641757, 34.44088739998413),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = Set()
    ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))..add(
      Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer()),
    )..add(
      Factory<HorizontalDragGestureRecognizer>(
              () => HorizontalDragGestureRecognizer()),
    )..add(
      Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
    );

  Set<Marker> markers = {};
  Set<Polyline> polyline = {};

  @override
  void onInit() {
    super.onInit();
    controller = Completer();

  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> goToTheLake() async {
    final GoogleMapController controllers = await controller!.future;
    controllers.animateCamera(CameraUpdate.newCameraPosition(kLake));
  }

  onMapCreated(GoogleMapController controllerMa) {
    if (!controller!.isCompleted) {
      controller?.complete(controllerMa);
    }
    //todo here we use two method first for me and another for the user
    //todo me = driver
    getMyCurrentMarkers();
    getUserMarkers();
  }

  onMapTaped(LatLng argument) {}

  Future<BitmapDescriptor> _getMarkerImageFromUrl(String url,
      {int? targetWidth, Color? color}) async {
    final File markerImageFile = await DefaultCacheManager().getSingleFile(url);
    if (targetWidth != null) {
      return _convertImageFileToBitmapDescriptor(markerImageFile,
          size: targetWidth, titleColor: color!);
    } else {
      Uint8List markerImageBytes = await markerImageFile.readAsBytes();
      return BitmapDescriptor.fromBytes(markerImageBytes);
    }
  }

  Future<BitmapDescriptor> _convertImageFileToBitmapDescriptor(File imageFile,
      {int size = 100,
        bool addBorder = false,
        Color borderColor = Colors.white,
        double borderSize = 10,
        Color titleColor = Colors.transparent,
        Color titleBackgroundColor = Colors.transparent}) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()
      ..color;
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
      icon: await _getMarkerImageFromUrl("https://scontent.fjrs2-2.fna.fbcdn.net/v/t39.30808-6/258867044_1337774763328553_6721770954985841116_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=HRPRVV5a1Q0AX_AqbjN&_nc_ht=scontent.fjrs2-2.fna&oh=00_AT_lk4raRmMFBvU74Dp4FZ9bySLd2ZCfr__aCUbNlWbrIw&oe=61F286A2",
          targetWidth: 180, color: colorTrans),
      position: const LatLng(31.523769049641757, 34.44088739998413),
      onTap: () {
        // showModalBottomSheet(
        //   backgroundColor: colorTrans,
        //   barrierColor: colorTrans,
        //   isDismissible: true,
        //   context: Get.context!,
        //   builder: (context) {
        //     return const SizedBox.shrink();
        //   },
        // );
      },
    );
    polyline.add( Polyline(polylineId:const  PolylineId("one"),color: colorBlack ,width: 1 ,geodesic: true,points: const [
      LatLng(31.523769049641757, 34.44088739998413),
      LatLng(31.354327, 34.299450),
    ]));
    markers.add(marker);
    update();
  }

  getUserMarkers() async {
    // markers.clear();

    final Marker marker = Marker(
      markerId: const MarkerId("{e.id.toString()س}"),
      icon: await _getMarkerImageFromUrl("https://scontent.fjrs2-2.fna.fbcdn.net/v/t1.6435-9/159622889_1167941780311853_4697952185015179188_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=174925&_nc_ohc=oY6Z0ijF12gAX-1BfZL&_nc_ht=scontent.fjrs2-2.fna&oh=00_AT8TzHQ2hjLTV7thzU8g3aNifCmySibPkY6Y9PVA3aY6tw&oe=62139BC9",
          targetWidth: 180, color: colorTrans),
      position: const LatLng(31.354327, 34.299450),
      onTap: () {
        // showModalBottomSheet(
        //   backgroundColor: colorTrans,
        //   barrierColor: colorTrans,
        //   isDismissible: true,
        //   context: Get.context!,
        //   builder: (context) {
        //     return const SizedBox.shrink();
        //   },
        // );
      },
    );
    markers.add(marker);
    update();
  }
}
