import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_driver/util/app_dimen.dart';

import '../../util/app_shaerd_data.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        loading(),
      ],
    );
  }

  Widget loading() {
    return Center(
      
      child: SvgPicture.asset(
        'assets/svgs/qatar_flag.svg',
        width: sizeW40,
        height: sizeH40,
      ),
    );
  }
}
