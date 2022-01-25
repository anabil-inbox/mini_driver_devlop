import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/details/order_details_started_screen.dart';
import 'package:inbox_driver/feature/view/screens/home/current_screen/Widgets/home_card.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/map_bottom_sheet.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

class CurrentScreen extends StatelessWidget {
  const CurrentScreen({Key? key}) : super(key: key);
  Widget get card => const HomeCard();
  
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Get.to(() => const OrderDetailsStarted());
      });
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return card;
                }),
          )
        ],
      ),
    );
  }
}
