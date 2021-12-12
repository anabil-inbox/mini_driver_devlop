import 'package:flutter/material.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';


class SeconderyFormButton extends StatelessWidget {
  final Function onClicked;

  final Color? color;

  const SeconderyFormButton({ Key? key , required this.buttonText, required this.onClicked,this.color}) : super(key: key);
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: sizeH50,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4)
      ),
      child: MaterialButton(
        color: color??seconderyButton,
        onPressed:  (){
          onClicked();
          // if (buttonText.toLowerCase()==("${tr.login_as_company.toString().toLowerCase()}")) {
          //    Get.off(() => CompanyBothLoginScreen());
          //  }else if(buttonText.toLowerCase()==("${tr.login_as_user.toString().toLowerCase()}")){
          //    Get.off(() => UserBothLoginScreen());
          //  }else if(buttonText.toLowerCase()==("${tr.register_as_user.toString().toLowerCase()}")){
          //    Get.off(() => UserRegisterScreen());
          //  }else if(buttonText.toLowerCase()==("${tr.register_as_company.toString().toLowerCase()}")){
          //    Get.off(() => RegisterCompanyScreen());
          //  }
        },
        child: Text("$buttonText" , style: textStyleHint()!.copyWith(color: colorHint , fontWeight: FontWeight.bold,fontSize: 15),),
      ),
    );
  }
}

