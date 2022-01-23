import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/screens/home/current_screen/Widgets/home_card.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({Key? key}) : super(key: key);
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
                itemCount: 2,
                itemBuilder: (context, index) {
                  return card;
                }),
          )
        ],
      ),
    );
  }
}
