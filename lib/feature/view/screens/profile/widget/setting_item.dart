import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';

class SettingItem extends StatelessWidget {
  const SettingItem(
      {Key? key,
      required this.iconPath,
      required this.settingTitle,
      required this.trailingTitle,
      required this.onTap})
      : super(key: key);

  final String settingTitle;
  final String trailingTitle;
  final String iconPath;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sizeH20!),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: colorTextWhite, borderRadius: BorderRadius.circular(4)),
      child: ListTile(
          onTap: () {
            onTap();
          },
          title: Text(settingTitle),
          leading: iconPath.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeH4!),
                  child: CircleAvatar(
                    child: SvgPicture.asset(iconPath),
                  ),
                )
              : const SizedBox(),
          contentPadding: const EdgeInsets.all(0),
          trailing: trailingTitle.isEmpty
              ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
              )
              : SizedBox(
                  width: sizeW95,
                  child: Row(
                    children: [
                      Text(
                        trailingTitle,
                        style: TextStyle(color: colorPrimary),
                      ),
                      SizedBox(
                        width: sizeW10,
                      ),
                     const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )
                    ],
                  ))),
    );
  }
}
