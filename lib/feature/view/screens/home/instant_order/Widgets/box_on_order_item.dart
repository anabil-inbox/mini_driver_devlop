// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/tasks/box_model.dart';
import 'package:inbox_driver/feature/view/screens/home/qr_scan/scan_screen.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/instant_order_bottom_sheet.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:inbox_driver/util/string.dart';

import '../../../../../../util/app_shaerd_data.dart';

class BoxOnOrderItem extends StatefulWidget {
  BoxOnOrderItem(
      {Key? key, required this.boxModel, required this.isShowingOperations})
      : super(key: key);



  BoxModel boxModel;
  final bool isShowingOperations;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  State<BoxOnOrderItem> createState() => _BoxOnOrderItemState();
}

class _BoxOnOrderItemState extends State<BoxOnOrderItem> {
  TextEditingController newSealController = TextEditingController();

  Widget get boxOperationSection {
    return Column(
      children: [
        SizedBox(
          height: sizeH12,
        ),
        TextFormField(
          controller: TextEditingController(
              text: widget.boxModel.selectedBoxOperations?.operation ?? ""),
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
                    widget.boxModel = BoxModel();
                    widget.boxModel = boxModel;
                  },
                  boxModel: widget.boxModel,
                  boxOperations: widget.boxModel.boxOperations ?? [],
                ),
                isScrollControlled: true);
            BoxOnOrderItem.homeViewModel.update();
          },
        ),
        SizedBox(
          height: sizeH12,
        ),
        GetBuilder<HomeViewModel>(
          initState: (con){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if( SharedPref.instance.getSeal(widget.boxModel.boxId.toString()).isNotEmpty){
                newSealController.text = SharedPref.instance.getSeal(widget.boxModel.boxId.toString());
                widget.boxModel.newSeal = SharedPref.instance.getSeal(widget.boxModel.boxId.toString());
                var indexOfBox = BoxOnOrderItem.homeViewModel.operationTask.scannedBoxes!.indexOf(widget.boxModel);
                BoxOnOrderItem.homeViewModel.operationTask.scannedBoxes![indexOfBox].newSeal = SharedPref.instance.getSeal(widget.boxModel.boxId.toString());
                BoxOnOrderItem.homeViewModel.update();

              }
            });
          },
          builder: (homeViewModel) {
            if(homeViewModel.scannedSeal.isNotEmpty){
              newSealController.text = homeViewModel.scannedSeal;
            }
            return widget.boxModel.selectedBoxOperations?.operation == Constance.sealed
                ? Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: newSealController,
                          textInputAction: TextInputAction.go,
                          keyboardType: TextInputType.numberWithOptions(),
                          minLines: 1,
                          maxLines: 1,
                          readOnly: widget.boxModel.selectedBoxOperations!.operation! == Constance.schedule,
                          onFieldSubmitted: (e) async {
                            await homeViewModel.createNewSeal(
                                serial: widget.boxModel.serial ?? "", newSeal: e);
                            widget.boxModel.newSeal = e;
                            SharedPref.instance.setSeal(seal: e, id: widget.boxModel.boxId.toString());
                              e = "";
                            hideFocus(Get.context!);
                            // homeViewModel.update();
                          },
                          validator: (e) {
                            if (e.toString().trim().isEmpty) {
                              return txtEnterNewSeal.tr;
                            }
                            return null;
                          },
                          decoration:
                              InputDecoration(hintText: txtEnterNewSealName.tr),
                        ),
                    ),
                    SizedBox(width: sizeW10!,),
                    InkWell(
                        onTap:()async {
                          if(widget.boxModel.selectedBoxOperations!.operation! == Constance.schedule){
                            return;
                          }
                          await homeViewModel.createNewSeal(
                              serial: widget.boxModel.serial ?? "", newSeal: newSealController.text.toString());
                          widget.boxModel.newSeal = newSealController.text.toString();
                          SharedPref.instance.setSeal(seal: newSealController.text.toString(), id: widget.boxModel.boxId.toString());
                           // newSealController.text = "";
                         hideFocus(Get.context!);
                          // homeViewModel.update();
                        },
                        child: SvgPicture.asset("assets/svgs/add_orange.svg")),
                    SizedBox(width: sizeW10!,),
                    InkWell(
                        onTap:()async {
                          if(widget.boxModel.selectedBoxOperations!.operation! == Constance.schedule){
                            return;
                          }
                          Get.to(() => const ScanScreen(
                            isScanDeliverdBoxes: false,
                            isFromScanSalesBoxs: false,
                            isProductScan: false,
                            isFromAddSeal :true,
                          ));

                        },
                        child: SvgPicture.asset("assets/svgs/Scan.svg",
                            color: colorRed, width: sizeW20, height: sizeH17)),
                  ],
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
                  txt: widget.boxModel.boxId,
                  textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                ),
              ],
            ),
            SizedBox(
              height: sizeH12,
            ),
            GetBuilder<HomeViewModel>(builder: (home) {
              if (!widget.isShowingOperations) {
                return const SizedBox();
              } else if (widget.boxModel.boxOperations == null ||
                  widget.boxModel.boxOperations!.isEmpty) {
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
