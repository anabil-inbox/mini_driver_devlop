import 'package:flutter/material.dart';
import 'package:inbox_driver/util/app_color.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: colorPrimary,
      ),
    );
  }
}
