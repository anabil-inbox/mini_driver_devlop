import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/string.dart';

class ContactItemWidget extends StatelessWidget {
  final String? flag;
  final String? prefix;
  final String? mobileNumber;
  final Function(String)? onChange;
  final Function()? deleteContact;

  const ContactItemWidget(
      {Key? key,
      this.flag,
      this.prefix,
      this.onChange,
      this.mobileNumber,
      this.deleteContact})
      : super(key: key);

  ProfileViewModle get viewModel => Get.find<ProfileViewModle>();
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: sizeH54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: colorTextWhite,
            ),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [

                SizedBox(
                  width: sizeW18,
                ),
                Row(
                  children: [
                    Text(
                      "$prefix",
                      textDirection: TextDirection.ltr,
                    ),
                    
                    SizedBox(
                      width: sizeH5,
                    ),
                    const VerticalDivider(),
                    
                  ],
                ),
                // Expanded(
                //   child: TextFormField(
                //     initialValue: "$mobileNumber",
                //     textDirection: TextDirection.ltr,
                //     maxLength: 10,
                //     onSaved: (newValue) {},
                //     decoration: const InputDecoration(
                //       counterText: "",
                //     ),
                //     onChanged: (value) {
                //       onChange!(value.toString());
                //     },
                //     onFieldSubmitted: (value) {
                //       onChange!(value.toString());
                //     },
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return txtErrorMobileNumber.tr;
                //       } else if (value.length > 10 || value.length < 8) {
                //         return txtErrorMobileNumber.tr;
                //       } else {
                //         return null;
                //       }
                //     },
                //     keyboardType: TextInputType.number,
                //   ),
                // ),
                Text("$mobileNumber")
              ],
            ),
          ),
        ),
        SizedBox(
          width: sizeW4,
        ),
        InkWell(
          onTap: deleteContact ?? () {},
          child: SvgPicture.asset(
            "assets/svgs/delete_box_widget.svg",
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
