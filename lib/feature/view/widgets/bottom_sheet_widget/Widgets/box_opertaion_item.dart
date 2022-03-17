import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/tasks/box_model.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';

import '../../custome_text_view.dart';

class BoxOperationItem extends StatelessWidget {
  const BoxOperationItem(
      {Key? key, required this.boxOperation , required this.boxModel , required this.onEnd})
      : super(key: key);

  final BoxOperation boxOperation;
  final BoxModel boxModel;
  final Function(BoxModel) onEnd;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (homeViewModel) {
        return GestureDetector(
          onTap: () async{
            homeViewModel.selectedBoxOperation = BoxOperation(operation: boxOperation.operation ?? "");
            homeViewModel.tdBoxOperaion.text = boxOperation.operation ?? "";
            boxModel.selectedBoxOperations = BoxOperation(operation: boxOperation.operation ?? "");
            
            onEnd(boxModel);
            homeViewModel.update();
            Get.back();
            if(boxModel.selectedBoxOperations?.operation ==  Constance.schedule){
             await homeViewModel.scheduleBox(serial: boxModel.boxId ?? "", salesOrder: homeViewModel.operationTask.salesOrder ?? "");
            }else if(boxModel.selectedBoxOperations?.operation ==  Constance.terminate){
              await homeViewModel.scheduleBox(serial: boxModel.boxId ?? "", salesOrder: homeViewModel.operationTask.salesOrder ?? "");

            }
          },
          child: Container(
            height: sizeH50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: colorTextWhite,
                border: Border.all(color: colorBtnGray)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeW10!),
              child: Row(
                children: <Widget>[
                  homeViewModel.selectedBoxOperation == boxOperation
                      ? SvgPicture.asset('assets/svgs/check.svg')
                      : SvgPicture.asset('assets/svgs/uncheck.svg'),
                  SizedBox(width: sizeW12),
                  CustomTextView(
                    txt: boxOperation.operation ?? "",
                    textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
