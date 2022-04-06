import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/tasks/box_model.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

import '../../../../util/app_color.dart';
import '../../../../util/app_dimen.dart';
import '../../../../util/string.dart';
import 'Widgets/box_opertaion_item.dart';

class InstantOrderBottomSheet extends StatelessWidget {
  const InstantOrderBottomSheet({Key? key, required this.boxOperations , required this.boxModel, required this.onEnd })
      : super(key: key);

  final List<BoxOperation> boxOperations;
  final BoxModel boxModel;
  final Function(BoxModel) onEnd;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: BoxDecoration(
        color: colorTextWhite,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.symmetric(horizontal: sizeH20!),
      child: GetBuilder<AuthViewModle>(
        init: AuthViewModle(),
        builder: (logic) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: sizeH12),
              SvgPicture.asset('assets/svgs/Indicator.svg'),
              SizedBox(height: sizeH25),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => BoxOperationItem(
                  onEnd: onEnd,
                  boxModel: boxModel,
                  boxOperation: boxOperations[index],
                ),
                itemCount: boxOperations.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: sizeH12,
                ),
              ),
              SizedBox(
                height: sizeH18,
              ),
              PrimaryButton(
                  isLoading: false,
                  textButton: txtCancel!.tr,
                  onClicked: () {
                    Get.back();
                  },
                  isExpanded: true),
              SizedBox(
                height: sizeH34,
              )
            ],
          );
        },
      ),
    );
  }
}
