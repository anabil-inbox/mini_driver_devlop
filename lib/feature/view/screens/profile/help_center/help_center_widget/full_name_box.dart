// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../../../../../../../util/app_color.dart';
// import '../../../../../../../../util/app_dimen.dart';
// import '../../../../../../../../util/app_shaerd_data.dart';
// import '../../../../../../../../util/constance.dart';
// import '../../../../widgets/custom_text_filed.dart';


// class FullName extends StatelessWidget {
//   const FullName({Key? key}) : super(key: key);

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
//           CustomTextFormFiled(
//             label: tr.txtFullNameScreen,
//             hintStyle:   TextStyle(fontSize: 14,color: colorTextHint1),
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