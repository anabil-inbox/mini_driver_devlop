import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';

class VisitLvItemWidget extends StatelessWidget {
  const VisitLvItemWidget({Key? key, this.isBlockContainer = false}) : super(key: key);
  final bool? isBlockContainer;
  Widget chipStatusWidget({var title, Color? titleColor, Color? backgroundColor, bool? isOutBound}) => Container(
        padding: EdgeInsets.symmetric(horizontal: sizeH10!, vertical: sizeH4!),
        margin: EdgeInsets.symmetric(horizontal: sizeW4!),
        decoration: BoxDecoration(
          color: backgroundColor ?? colorBlueLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (isOutBound != null && isOutBound)
                SvgPicture.asset(
                  "assets/svgs/out_bound_fig.svg",
                  color: titleColor ?? colorBlue,
                ),
              if (isOutBound != null && !isOutBound)
                SvgPicture.asset(
                  "assets/svgs/in_bound_fig.svg",
                  color: titleColor ?? colorBlue,
                ),
              SizedBox(
                width: sizeW4!,
              ),
              CustomTextView(
                txt: title ?? "Out Bound",
                textStyle: textStyleNormal()?.copyWith(
                    color: titleColor ?? colorBlue, fontSize: fontSize13),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: sizeW10!, right: sizeW10!, top: sizeH10!),
          padding: EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH17!),
          decoration: BoxDecoration(
            color: colorTextWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Stack(
                    children: [
                      SvgPicture.asset('assets/svgs/Folder_Shared.svg'),
                      PositionedDirectional(
                        start: 0,
                        top: 0,
                        end: 0,
                        bottom: 0,
                        child: CustomTextView(
                          txt: "X5",
                          textAlign: TextAlign.center,
                          textStyle: textStyleNormal()
                              ?.copyWith(color: colorTextWhite),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  chipStatusWidget(isOutBound: false),
                  chipStatusWidget(),
                ],
              ),
              SizedBox(height: sizeH10),
              CustomTextView(
                txt: "Helena Brauer",
                textStyle: textStyleNormal()?.copyWith(color: colorBlack),
              ),
              SizedBox(height: sizeH5),
              CustomTextView(
                txt: "20 Wadi Alsail, 918 Alreef st.Building no.10",
                textStyle: textStyleNormal()?.copyWith(fontSize: fontSize13),
                maxLine: Constance.maxLineTwo,
              ),
              SizedBox(height: sizeH10),
              CustomTextView(
                txt: "20/06/2021 07:00 PM",
                textStyle: textStyleNormal()?.copyWith(
                    fontSize: fontSize12,
                    color: colorTextHint.withOpacity(0.7)),
              ),
            ],
          ),
        ),
        //TODO: this for Make CAll
        PositionedDirectional(
            bottom: sizeH20,
            end: sizeW30,
            child: SvgPicture.asset(
              "assets/svgs/call_red_fig.svg",
            )),
        //TODO: this for block container
        if(isBlockContainer!)
        Container(
          margin: EdgeInsets.only(left: sizeW10!, right: sizeW10!, top: sizeH10!),
          width: double.infinity,
          height: sizeH140,
          decoration: BoxDecoration(
            color: colorTextWhite.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
