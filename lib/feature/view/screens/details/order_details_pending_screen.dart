import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/address_box_widget.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/name_box_widget.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/schedule%20_box_widget.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';

class OrderDetailsPending extends StatelessWidget {
  const OrderDetailsPending({Key? key}) : super(key: key);

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
            PositionedDirectional(
                bottom: padding32,
                start: padding20,
                end: padding20,
                child: PrimaryButton(
                  isExpanded: true,
                  isLoading: false,
                  textButton: "Start",
                  onClicked: () {},
                ))
          ],
        ),
      ),
    );
  }
}
