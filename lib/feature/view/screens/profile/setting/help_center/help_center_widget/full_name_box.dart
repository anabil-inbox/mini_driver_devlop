// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
// import 'package:inbox_driver/util/string.dart';
//
// import '../../../../../../../../util/app_color.dart';
// import '../../../../../../../../util/app_dimen.dart';
// import '../../../../../../../../util/app_shaerd_data.dart';
// import '../../../../../../../../util/constance.dart';
//
//
// class FullName extends StatelessWidget {
//   const FullName({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     screenUtil(context);
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: padding4!),
//       decoration: BoxDecoration(
//           color: colorBackground,
//           borderRadius: BorderRadius.circular(padding16!)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           CustomTextFormFiled(
//             label: txtFullName.tr,
//             hintStyle:   const TextStyle(fontSize: 14,color: colorTextHint1),
//             maxLine: Constance.maxLineOne,
//             keyboardType: TextInputType.text,
//             onSubmitted: (_) {},
//             onChange: (value) {},
//             isSmallPadding: false,
//             isSmallPaddingWidth: true,
//             fillColor: colorBackground,
//             isFill: true,
//             isBorder: true,
//           ),
//         ],
//       ),
//     );
//   }
// }