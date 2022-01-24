import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';

import 'map_driver.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding16!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeH13,
          ),
          SizedBox(
            height: sizeH4,
          ),
          RichText(
            text: TextSpan(
              style: textStyleNormal(),
              children: const [
                TextSpan(
                  text: 'Delivery Address',
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const MapDriver());
            },
            child: TextFormField(
              decoration: InputDecoration(
                enabled: false,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    "assets/png/Location.png",
                    width: 10,
                    height: 10,
                  ),
                ),
                // suffixIcon: SvgPicture.asset(
                //   "assets/svgs/location.svg",
                //   color: Colors.transparent,
                // ),
                suffixStyle: const TextStyle(color: Colors.transparent),
                contentPadding: const EdgeInsets.all(1.0),
                hintText: "Zone No., Street No., Building No.",
              ),
            ),
          ),
          // TextFormField(
          //   decoration: InputDecoration(
          //       enabled: false,
          //       suffixIcon: Padding(
          //         padding: const EdgeInsets.all(5.0),
          //         child: Image.asset(
          //           "assets/png/Location.png",
          //           fit: BoxFit.fill,
          //           width: 10,
          //           height: 10,
          //         ),
          //       ),
          //       suffixStyle: const TextStyle(color: Colors.transparent),
          //       contentPadding: const EdgeInsets.all(1.0),
          //       hintText: "Zone No., Street No., Building No."),
          // ),
          SizedBox(
            height: sizeH1,
          ),
          SizedBox(
            height: sizeH1,
          ),
        ],
      ),
    );
  }
}
