import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';

class MapDriver extends StatelessWidget {
  const MapDriver({Key? key}) : super(key: key);

  // class MapDriver extends StatefulWidget {
  // @override
  // State<MapDriver> createState() => _MapDriverState();
  // }
  //
  // class _MapSampleState extends State<MapDriver> {
  // ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();
  //
  // @override
  // void initState() {
  // super.initState();
  //
  // profileViewModle.googlePlace = GooglePlace("AIzaSyAzBtxE3NluLYNrUajTg9OnG7X_luzESvU");
  // // profileViewModle.currentPostion = LatLng(profileViewModle.latitude, profileViewModle.longitude);
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarWidget(
      leadingWidth: sizeW50,
      isCenterTitle: true,
      titleWidget: GetBuilder<ProfileViewModle>(
        builder: (_) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    maxLines: 1,
                    minLines: 1,
                    // controller: profileViewModle.tdSearchMap,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: scaffoldColor,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            "assets/svgs/search_icon.svg",
                          ),
                        ),
                        hintText: "search_for_country"),
                    onChanged: (newVal) {
                      if (newVal.isNotEmpty)
                        //   profileViewModle.autoCompleteSearch(newVal);
                        // profileViewModle.isSearching = true;
                        // profileViewModle.update();
                        ;
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ));
  }
}
