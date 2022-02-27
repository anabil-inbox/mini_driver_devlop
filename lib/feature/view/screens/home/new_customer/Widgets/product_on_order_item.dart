import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:inbox_driver/feature/model/tasks/product_model.dart';
import 'package:inbox_driver/feature/model/tasks/task_response.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';

class ProductOnOrderItem extends StatelessWidget {
  const ProductOnOrderItem({Key? key, required this.productModel})
      : super(key: key);

  final Item productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: sizeH10!),
      padding: EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH17!),
      height: sizeH60,
      decoration: BoxDecoration(
        color: colorSearchBox,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          const CircleAvatar(
            radius: sizeRadius10,
            backgroundImage: AssetImage('assets/png/profile.png'),
          ),
          SizedBox(width: sizeW10),
          CustomTextView(
            txt: productModel.name,
            textStyle: textStyleNormal()?.copyWith(color: colorBlack),
          ),
          SizedBox(width: sizeW48),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: sizeH10!, vertical: sizeH4!),
            decoration: BoxDecoration(
              color: colorTextWhite,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: CustomTextView(
                txt: "1",
                textStyle: textStyleNormal()
                    ?.copyWith(color: colorRed, fontSize: fontSize13),
              ),
            ),
          ),
          SizedBox(width: sizeW12),
          Container(
            width: sizeW30,
            height: sizeH30,
            decoration: BoxDecoration(
              color: colorRed.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
                child: SvgPicture.asset(
              'assets/svgs/delete_widget.svg',
              color: colorRed,
              width: sizeW15,
              height: sizeH16,
            )),
          )
        ],
      ),
    );
  }
}
