import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/screens/home/current_screen/Widgets/home_card.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:get/get.dart';

class CurrentScreen extends StatelessWidget {
  const CurrentScreen({Key? key}) : super(key: key);
  Widget get card => const HomeCard();
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
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
