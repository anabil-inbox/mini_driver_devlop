import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inbox_driver/feature/view_model/map_view_model/map_view_model.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

class MapBottomSheet extends StatelessWidget {
  const MapBottomSheet({Key? key}) : super(key: key);

  Widget get closeBtnWidget => InkWell(
    child: SvgPicture.asset("assets/svgs/Close.svg"),
    onTap: () {
      Get.back();
    },
  );
  @override
  Widget build(BuildContext context) {
    screenUtil(context);

    return GetBuilder<MapViewModel>(
        init:MapViewModel(),
        builder: (logic) {
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(sizeRadius25!),topLeft: Radius.circular(sizeRadius25!))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:  [
            SizedBox(height: sizeH80,),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(sizeRadius25!),topLeft: Radius.circular(sizeRadius25!)),
                          child: GoogleMap(
                            myLocationButtonEnabled: true,
                            initialCameraPosition:logic.initialCameraPosition,
                            zoomControlsEnabled: true,
                            mapType: MapType.normal,
                            mapToolbarEnabled: true,
                            myLocationEnabled: true,
                            zoomGesturesEnabled: true,
                            scrollGesturesEnabled: true,
                            rotateGesturesEnabled: false,
                            onTap: (argument) => logic.onMapTaped(argument),
                            markers: logic.markers,
                            polylines: logic.polyLines,
                            gestureRecognizers: logic.gestureRecognizers,
                            onMapCreated: (GoogleMapController controller) => logic.onMapCreated(controller),
                          ),
                        ),
                      ),
                    ],
                  ),
                  PositionedDirectional(
                    start:sizeW20 ,
                    top: sizeH20,
                    height: sizeH30,
                    width: sizeW30,
                    child:closeBtnWidget ,
                  ),

                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
