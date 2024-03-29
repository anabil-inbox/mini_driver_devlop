import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:signature/signature.dart';

import '../custome_text_view.dart';

class SignatureBottomSheet extends StatefulWidget {
  const SignatureBottomSheet({Key? key, required this.onSignatureCallBack, this.isContractSign = false})
      : super(key: key);
  final Function(SignatureController?)? onSignatureCallBack;
  final bool? isContractSign;

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  static void showSignatureBottomSheet({bool? isContractSign = false}) {
    Get.bottomSheet(SignatureBottomSheet(
        isContractSign:isContractSign,
      onSignatureCallBack: (SignatureController? controller) {
        controller?.toPngBytes();
        controller?.toImage();
      },
    ), isScrollControlled: true);
  }

  @override
  State<SignatureBottomSheet> createState() => _SignatureBottomSheetState();
}

class _SignatureBottomSheetState extends State<SignatureBottomSheet> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.grey,
  );

  Widget get signatureControllerWidget => Container(
        decoration: BoxDecoration(color: colorUnSelectedWidget),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //SHOW EXPORTED IMAGE IN NEW ROUTE
            IconButton(
              icon: const Icon(Icons.check),
              color: Colors.black,
              onPressed: onCheckBtnClick,
            ),
            IconButton(
              icon: const Icon(Icons.undo),
              color: Colors.black,
              onPressed: () {
                setState(() => _controller.undo());
              },
            ),
            IconButton(
              icon: const Icon(Icons.redo),
              color: Colors.black,
              onPressed: () {
                setState(() => _controller.redo());
              },
            ),
            //CLEAR CANVAS
            IconButton(
              icon: const Icon(Icons.clear),
              color: Colors.black,
              onPressed: () {
                setState(() => _controller.clear());
              },
            ),
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return SingleChildScrollView(
      primary: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
          color: colorTextWhite,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: sizeH20),
            SvgPicture.asset('assets/svgs/Indicator.svg'),
            SizedBox(height: sizeH20),
            CustomTextView(
              txt: txtAddSignature.tr,
              textStyle: textStyleNormal()
                  ?.copyWith(fontSize: fontSize18, color: colorBlack),
            ),
            SizedBox(height: sizeH14),
            Signature(
              controller: _controller,
              height: sizeH300,
              width: double.infinity,
              backgroundColor: colorUnSelectedWidget,
            ),
            SizedBox(height: sizeH10),
            signatureControllerWidget,
            SizedBox(height: sizeH10),
          ],
        ),
      ),
    );
  }

  //this for view the signature in other screen
  void onCheckBtnClick() async {
    if (_controller.isNotEmpty) {
      final Uint8List? data = await _controller.toPngBytes();
      if (data != null) {
        SignatureBottomSheet.homeViewModel.signatureOutput = data;
        if(widget.isContractSign!){
          var operationTask = SignatureBottomSheet.homeViewModel.operationTask;
          await SignatureBottomSheet.homeViewModel.uploadVerficationId(
              customerId: operationTask.customerId.toString(),
              taskId: operationTask.taskId.toString());
        }else {
          await SignatureBottomSheet.homeViewModel.uploadCustomerSignature();
        }
        SignatureBottomSheet.homeViewModel.update();
        Get.back();
        // await Navigator.of(context).push(
        //   MaterialPageRoute<void>(
        //     builder: (BuildContext context) {
        //       return Scaffold(
        //         appBar: AppBar(),
        //         body: Center(
        //           child: Container(
        //             color: colorUnSelectedWidget,
        //             child: Image.memory(data ,
        //               height: (MediaQuery.of(context).size.height / 2),
        //               width: (MediaQuery.of(context).size.width),),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // );
      }
    }
  }
}
