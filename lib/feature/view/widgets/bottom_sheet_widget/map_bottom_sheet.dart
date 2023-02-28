import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';
import 'package:inbox_driver/feature/view_model/map_view_model/map_view_model.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

class MapBottomSheet extends StatelessWidget {
  const MapBottomSheet({Key? key, required this.salesOrder}) : super(key: key);

  static MapViewModel get mapViewModel => Get.find<MapViewModel>();

  final SalesOrder salesOrder;

  Widget get closeBtnWidget => InkWell(
        child: SizedBox(
            width: sizeW30,
            height: sizeH30,
            child: SvgPicture.asset("assets/svgs/Close_orange.svg" ,)),
        onTap: () {
          Get.back();
        },
      );
  Widget get closeBtnTraWidget => SizedBox(
      width: sizeW30,
      height: sizeH30,
      child: SvgPicture.asset("assets/svgs/Close_orange.svg" , /*close.svg*/color: Colors.transparent,));
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<MapViewModel>(
        initState: (_) async {
          mapViewModel.getDirections();
          mapViewModel.customerLatLng =
              LatLng(salesOrder.latituide ?? 0, salesOrder.longitude ?? 0);
          mapViewModel.update();
        },
        builder: (logic) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(sizeRadius25!),
                    topLeft: Radius.circular(sizeRadius25!))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: sizeH80,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(sizeRadius25!),
                                  topLeft: Radius.circular(sizeRadius25!)),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: GoogleMap(
                                  myLocationButtonEnabled: true,
                                  initialCameraPosition:
                                      logic.initialCameraPosition,
                                  zoomControlsEnabled: true,
                                  mapType: MapType.normal,
                                  mapToolbarEnabled: true,
                                  myLocationEnabled: true,
                                  zoomGesturesEnabled: true,
                                  scrollGesturesEnabled: true,
                                  rotateGesturesEnabled: false,
                                  compassEnabled: false,
                                  onTap: (argument) => logic.onMapTaped(argument),
                                  markers: logic.markers,
                                  polylines: logic.polyLines,
                                  gestureRecognizers: logic.gestureRecognizers,
                                  onMapCreated:
                                      (GoogleMapController controller) =>
                                          logic.onMapCreated(controller,
                                              salesOrder: salesOrder),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: sizeW20,
                        // left: sizeW20,
                        // right: MediaQuery.of(context).size.width *0.80,
                        // height: sizeH60,
                        // width: sizeW60,
                        child: Container(
                            width: MediaQuery.of(context).size.width ,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: sizeW20! ),
                            color: Colors.transparent,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              textDirection: TextDirection.ltr,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                closeBtnWidget,
                                closeBtnTraWidget,
                              ],
                            )),
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
