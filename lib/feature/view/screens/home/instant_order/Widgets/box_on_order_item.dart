// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/tasks/box_model.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/instant_order_bottom_sheet.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/string.dart';

import '../../../../../../util/app_shaerd_data.dart';

class BoxOnOrderItem extends StatelessWidget {
  BoxOnOrderItem(
      {Key? key, required this.boxModel, required this.isShowingOperations})
      : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  BoxModel boxModel;
  final bool isShowingOperations;

  Widget get boxOperationSection {
    return Column(
      children: [
        SizedBox(
          height: sizeH12,
        ),
        TextFormField(
          controller: TextEditingController(
              text: boxModel.selectedBoxOperations?.operation ?? ""),
          decoration: InputDecoration(
              hintText: txtChooseBoxOperation.tr,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(padding10),
                child: SvgPicture.asset("assets/svgs/dropdown.svg"),
              )),
          readOnly: true,
          onTap: () async {
            await Get.bottomSheet(
                InstantOrderBottomSheet(
                  onEnd: (boxModel) async {
                    this.boxModel = BoxModel();
                    this.boxModel = boxModel;
                  },
                  boxModel: boxModel,
                  boxOperations: boxModel.boxOperations ?? [],
                ),
                isScrollControlled: true);
            homeViewModel.update();
          },
        ),
        SizedBox(
          height: sizeH12,
        ),
        GetBuilder<HomeViewModel>(
          builder: (homeViewModel) {
            return boxModel.selectedBoxOperations?.operation == Constance.sealed
                ? TextFormField(
                    textInputAction: TextInputAction.go,
                    minLines: 2,
                    maxLines: 2,
                    onFieldSubmitted: (e) async {
                      await homeViewModel.createNewSeal(
                          serial: boxModel.serial ?? "", newSeal: e);
                      boxModel.newSeal = e;
                      e = "";
                      homeViewModel.update();
                    },
                    validator: (e) {
                      if (e.toString().trim().isEmpty) {
                        return "Please enter the New Seal";
                      }
                      return null;
                    },
                    decoration:
                        const InputDecoration(hintText: "Enter New Seal Name"),
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      margin: const EdgeInsets.only(bottom: padding10),
      child: InkWell(
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/svgs/Folder_Shared.svg'),
                SizedBox(width: sizeW5),
                CustomTextView(
                  txt: boxModel.boxId,
                  textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                ),
              ],
            ),
            SizedBox(
              height: sizeH12,
            ),
            GetBuilder<HomeViewModel>(builder: (home) {
              if (!isShowingOperations) {
                return const SizedBox();
              } else if (boxModel.boxOperations == null ||
                  boxModel.boxOperations!.isEmpty) {
                return const SizedBox();
              } else {
                return boxOperationSection;
              }
            }),
          ],
        ),
      ),
    );
  }
}
