import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/address_box_widget.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/name_box_widget.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/schedule%20_box_widget.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view/widgets/secondery_button.dart';
import 'package:inbox_driver/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';

class OrderDetailsStarted extends StatelessWidget {
  const OrderDetailsStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: Text(
          "Order Details",
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding20!),
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: sizeH27,
                ),
                const NameBox(),
                SizedBox(
                  height: sizeH10,
                ),
                const AddressBox(),
                SizedBox(
                  height: sizeH10,
                ),
                const ScheduleBox(),
                SizedBox(
                  height: sizeH10,
                ),
              ],
            ),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    isExpanded: false,
                    isLoading: false,
                    onClicked: () {
                    },
                    textButton: "Delivered",
                  ),
                  SizedBox(
                    width: sizeW12,
                  ),
                  SizedBox(
                    width: sizeW150,
                    child: SeconderyFormButton(
                      buttonText: "No Show",
                      onClicked: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
