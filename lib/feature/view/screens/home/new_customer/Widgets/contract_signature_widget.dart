import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/signature_bottom_sheet.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';

class ContractSignature extends StatelessWidget {
  const ContractSignature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<HomeViewModel>(
        builder: (logic) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: sizeW5!, vertical: sizeH13!),
            height: sizeH50,
            decoration: BoxDecoration(
              color: colorTextWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () {
                logic.isSelected = !logic.isSelected;
                logic.update();
                if(logic.isSelected){
                  SignatureBottomSheet.showSignatureBottomSheet();
                }
              },
              child: Row(
                children: <Widget>[
                  Container(
                    height: sizeH30,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: logic.operationTask.isNew ??
                                  false
                              ? colorRed
                              : colorBtnGray),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        child: Container(
                            decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: logic.operationTask.isNew ??
                                  false
                              ? Colors.transparent
                              : colorRed,
                        )),
                        // backgroundColor: colorRed,
                      ),
                    ),
                  ),
                  SizedBox(width: sizeW5),
                  CustomTextView(
                    txt: txtContractSignature.tr,
                    textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
