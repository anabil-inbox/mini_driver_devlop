// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../../../../../../../util/app_color.dart';
// import '../../../../../../../../util/app_dimen.dart';
// import '../../../../../../../../util/app_shaerd_data.dart';
// import '../../../../../../../../util/constance.dart';


// class WriteHere extends StatelessWidget {
//   const WriteHere({Key? key}) : super(key: key);

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
//             label: tr.txtWriteHer,
//             maxLine: Constance.maxLineSaven,
//             hintStyle:   TextStyle(fontSize: 14,color: colorTextHint1),
//             textInputAction: TextInputAction.send,
//             keyboardType: TextInputType.text,
//             onSubmitted: (_) {},
//             onChange: (value) {},
//             isSmallPadding: false,
//             isSmallPaddingWidth: true,
//             fillColor: colorBackground,
//             isFill: true,
//             isBorder: true,
//           ),
//           SizedBox(height: sizeH75),
//         ],
//       ),
//     );
//   }
// }
