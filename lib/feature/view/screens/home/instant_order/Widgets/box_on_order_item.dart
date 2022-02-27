import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_driver/feature/model/tasks/box_model.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';

class BoxOnOrderItem extends StatelessWidget {
  const BoxOnOrderItem({Key? key , required this.boxModel}) : super(key: key);

  final BoxModel boxModel;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: padding10),
      child: InkWell(
        child: Row(
          children: [
            SvgPicture.asset('assets/svgs/Folder_Shared.svg'),
            SizedBox(width: sizeW5),
            CustomTextView(
              txt: boxModel.boxName,
              textStyle: textStyleNormal()?.copyWith(color: colorBlack),
            )
            
          ],
        ),
      ),
    );
  }
}
