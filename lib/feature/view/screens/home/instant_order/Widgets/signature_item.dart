import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/signature_item_model.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';

class SignatureItem extends StatelessWidget {
  const SignatureItem({Key? key, required this.title, required this.onSelected})
      : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  final String title;
  final Function onSelected;


  Widget photoSignature() {
    if (title == Constance.fingerprint) {
      return const SizedBox();
    }
    /*if (title == homeViewModel.selectedSignatureItemModel.title &&
        homeViewModel.operationTask.signatureFile != null)*/
    if ( title == homeViewModel.operationTask.signatureType &&
        homeViewModel.operationTask.signatureType ==
            homeViewModel.selectedSignatureItemModel.title &&
        homeViewModel.operationTask.signatureFile != null) {
      return imageNetwork(
        url: ConstanceNetwork.imageUrl +
            (homeViewModel.operationTask.signatureFile ?? ""),
        width: sizeW30,
        height: sizeH30,
      );
    }
    return const SizedBox();
  }


  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: colorTextWhite,
          border: Border.all(color: colorBtnGray)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeW10!, vertical: sizeH2!),
        child: GetBuilder<HomeViewModel>(
          builder: (_) {
            return Row(
              children: [
                GetBuilder<HomeViewModel>(
                  builder: (home) {
                    return IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          homeViewModel.selectedSignatureItemModel =
                              SignatureItemModel(title: title);
                          homeViewModel.update();
                          onSelected();
                        },
                        icon: homeViewModel.selectedSignatureItemModel.title ==
                                title
                            // SharedPref.instance
                            //             .getCurrentTaskResponse()
                            //             ?.signatureType ==
                            //         title
                            ? SvgPicture.asset("assets/svgs/check.svg")
                            : SvgPicture.asset("assets/svgs/uncheck.svg"));
                  },
                ),
                SizedBox(width: sizeW5),
                CustomTextView(
                  txt: title,
                  textStyle: textStyleNormal()?.copyWith(fontSize: fontSize13),
                ),
                const Spacer(),
                photoSignature(),
                Transform(
                  transform:
                      Matrix4.translationValues(isArabicLang() ? -5 : 5, 0, 0),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: colorBlack,
                    size: 20,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
