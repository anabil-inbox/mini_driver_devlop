import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';

class CustomTextFormFiled extends StatelessWidget /*with AppDimen, AppStyle */ {
  final String? label;
  final TextInputType? keyboardType;
  final bool? obscureText, isBorder, isFill, isInputFormatters;
  final Function(String)? customValid;
  final Function(String)? onSubmitted;
  final Function(String)? onChange;
  final TextEditingController? controller;
  final Color? fillColor, iconColor, suffixIconColor, enabledBorderColor;
  final VoidCallback? fun;
  final TextInputAction? textInputAction;
  final bool? isSmallPadding, isSmallPaddingWidth, isReadOnly;
  final int? maxLine, minLine;
  final TextAlign? textAlign;
  final int? maxLength;
  final FocusNode? focusNode, nexFocusNode;
  final bool? autoFocus;
  final TextStyle? hintStyle;
  final IconData? icon;
  final double? iconSize;

  const CustomTextFormFiled(
      {Key? key,
      this.label,
      this.keyboardType,
      this.obscureText = false,
      this.customValid,
      this.controller,
      this.isBorder = true,
      this.isFill = false,
      this.fillColor,
      this.isInputFormatters = false,
      this.fun,
      this.textInputAction,
      this.isSmallPadding = false,
      this.maxLine,
      this.isSmallPaddingWidth = false,
      this.minLine,
      this.isReadOnly = false,
      this.textAlign,
      this.maxLength,
      this.onSubmitted,
      this.iconColor,
      this.suffixIconColor,
      this.onChange,
      this.focusNode,
      this.nexFocusNode,
      this.hintStyle,
      this.autoFocus = false,
      this.icon,
      this.iconSize,
      this.enabledBorderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return TextFormField(
      maxLength: maxLength,
      autofocus: autoFocus!,
      focusNode: focusNode,
      onTap: fun,
      cursorColor: colorPrimary,
      textAlignVertical: TextAlignVertical.top,
      textAlign: textAlign ?? TextAlign.start,
      controller: controller,
      obscureText: obscureText!,
      obscuringCharacter: '*',
      maxLines: maxLine ?? 1,
      minLines: minLine ?? 1,
      readOnly: isReadOnly ?? false,
      style: textInputFiled()?.copyWith(color: colorPrimaryDark),
      // textDirection: TextDirection.ltr,
      // textDirection:obscureText!?TextDirection.ltr:TextDirection.rtl ,
      textInputAction: textInputAction ?? TextInputAction.newline,
      // ignore: missing_return
      validator: (String? value) {
        if (value!.isEmpty || value == "") {
          // return messageFiled?.tr;
        } else if (customValid != null) {
          return customValid!(value);
        } else {
          return null;
        }
         return null;
      },
      onChanged: (value) {
        if (onChange != null) onChange!(value);
      },
      onFieldSubmitted: (value) {
        try {
          focusNode?.unfocus();
          FocusScope.of(context).requestFocus(nexFocusNode /*?? FocusNode()*/);
          onSubmitted!(value);
        } catch (e) {
          focusNode?.unfocus();
        }
      },
      onSaved: (newValue) {
        focusNode?.unfocus();
        FocusScope.of(context)
            .requestFocus(nexFocusNode /*?? FocusNode()*/); //remo
      },
      decoration: icon == null ? inputDecoration() : inputDecorationWithIcon(),

      keyboardType: keyboardType ?? TextInputType.emailAddress,

      inputFormatters: isInputFormatters!
          ? [FilteringTextInputFormatter.digitsOnly, CustomInputFormatter()]
          : [],
    );
  }

  InputDecoration inputDecorationWithIcon() {
    return InputDecoration(
        prefixIcon: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        prefixIconConstraints: icon == null
            ? const BoxConstraints(maxWidth: 0, minWidth: 0)
            : const BoxConstraints(
                minWidth: 38,
                minHeight: 25,
              ),
        counterText: "",
        isDense: true,
        filled: isFill,
        errorStyle: const TextStyle(
            /*  height: 0,*/ /*backgroundColor: colorBackground*/
            ),
        enabledBorder: isFill!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(sizeRadius!),
                borderSide: BorderSide(color: colorTrans))
            : UnderlineInputBorder(
                borderRadius: BorderRadius.circular(sizeRadius!),
                borderSide: BorderSide(color: colorBorderTextFiled)),
        fillColor: fillColor ?? colorBackground,
        contentPadding: EdgeInsets.only(
            left: isSmallPaddingWidth! ? sizeW10! : sizeW40!,
            right: isSmallPaddingWidth! ? sizeW10! : sizeW26!,
            top: isSmallPadding! ? sizeW12! : sizeH20!,
            bottom: isSmallPadding! ? sizeW12! : sizeH20!),
        hintText: label,
        hintStyle:
            hintStyle ?? textInputFiledHint()?.copyWith(color: colorTextHint),
        focusedBorder: isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(sizeRadius!),
                borderSide:
                    BorderSide(color: fillColor ?? colorPrimary, width: 2))
            : InputBorder.none,
        errorBorder: isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(sizeRadius!),
                borderSide:
                    BorderSide(color: fillColor ?? colorPrimary, width: 2))
            : InputBorder.none,
        border: isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(sizeRadius!),
                borderSide: BorderSide(color: colorBorderTextFiled))
            : InputBorder.none);
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
        counterText: "",
        isDense: true,
        filled: isFill,

        errorStyle: const TextStyle(
            /*  height: 0,*/ /*backgroundColor: colorBackground*/
            ),
        enabledBorder: enabledBorderColor != null
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizeRadius!),
                borderSide: BorderSide(color: enabledBorderColor!))
            : isFill!
                ? UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(sizeRadius!),
                    borderSide: BorderSide(color: colorTrans))
                : UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(sizeRadius!),
                    borderSide: BorderSide(color: colorBorderTextFiled)),
        fillColor: fillColor ?? colorBackground,
        contentPadding: EdgeInsets.only(
            left: isSmallPaddingWidth! ? sizeW10! : sizeW40!,
            right: isSmallPaddingWidth! ? sizeW10! : sizeW26!,
            top: isSmallPadding! ? sizeW12! : sizeH20!,
            bottom: isSmallPadding! ? sizeW12! : sizeH20!),
        hintText: label,
        hintStyle: hintStyle ?? textInputFiledHint(),
        errorBorder: isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(sizeRadius!),
                borderSide:
                    BorderSide(color: fillColor ?? colorPrimary, width: 2))
            : InputBorder.none,
        focusedBorder: isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(sizeRadius!),
                borderSide:
                    BorderSide(color: fillColor ?? colorPrimary, width: 2))
            : InputBorder.none,
        border: isBorder!
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(sizeRadius!),
                borderSide: BorderSide(color: colorBorderTextFiled))
            : InputBorder.none);
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer =  StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(
            ' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
