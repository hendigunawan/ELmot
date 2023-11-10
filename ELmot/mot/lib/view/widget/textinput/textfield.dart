import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';

import '../../../core/responsive/breakpoints.dart';
import 'masked_input_formator.dart';

class CustomTextInput extends StatefulWidget {
  const CustomTextInput(
      {super.key, required this.hintTextString,
      required this.textEditController,
      required this.inputType,
      this.enableBorder = true,
      this.themeColor,
      this.cornerRadius,
      this.maxLength,
      this.prefixIcon,
      this.textColor,
      this.errorMessage,
      this.labelText});

  // ignore: prefer_typing_uninitialized_variables
  final hintTextString;
  final TextEditingController textEditController;
  final InputType inputType;
  final bool enableBorder;
  final Color? themeColor;
  final double? cornerRadius;
  final int? maxLength;
  final Widget? prefixIcon;
  final Color? textColor;
  final String? errorMessage;
  final String? labelText;

  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

// input text state
class _CustomTextInputState extends State<CustomTextInput> {
  bool _isValidate = true;
  String validationMessage = '';
  bool visibility = false;
  int oldTextSize = 0;

  // build method for UI rendering
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Responsive.isDesktop(context) || Responsive.isTablet(context)
                  ? 0.1.w
                  : 24.0.w,
          vertical: 8.0.h),
      child: TextField(
        controller: widget.textEditController,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize:
                Responsive.isDesktop(context) || Responsive.isTablet(context)
                    ? FontSizes.size3
                    : FontSizes.size13,
          ),
          hintText: widget.hintTextString as String,
          hintStyle: TextStyle(
              fontSize:
                  Responsive.isDesktop(context) || Responsive.isTablet(context)
                      ? FontSizes.size5
                      : FontSizes.size13),
          errorText: _isValidate ? null : validationMessage,
          counterText: '',
          border: getBorder(),
          enabledBorder: widget.enableBorder ? getBorder() : InputBorder.none,
          focusedBorder: widget.enableBorder ? getBorder() : InputBorder.none,
          labelText: widget.labelText ?? widget.hintTextString as String,
          labelStyle: getTextStyle(),
          prefixIcon: widget.prefixIcon ?? getPrefixIcon(),
          suffixIcon: getSuffixIcon(),
        ),
        onChanged: checkValidation,
        keyboardType: getInputType(),
        obscureText: widget.inputType == InputType.Password && !visibility,
        maxLength: widget.inputType == InputType.PaymentCard
            ? 19
            : widget.maxLength ?? getMaxLength(),
        style: TextStyle(
            color: widget.textColor ?? Colors.black,
            fontSize:
                Responsive.isDesktop(context) || Responsive.isTablet(context)
                    ? FontSizes.size5
                    : FontSizes.size13),
        inputFormatters: [getFormatter()],
      ),
    );
  }

  //get border of textinput filed
  OutlineInputBorder getBorder() {
    return OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(widget.cornerRadius ?? 12.0.r)),
      borderSide: BorderSide(
          width: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? 0.4.w
              : 2.w,
          color: widget.themeColor ?? Theme.of(context).primaryColor),
      gapPadding: 2.w,
    );
  }

  // formatter on basis of textinput type
  TextInputFormatter getFormatter() {
    if (widget.inputType == InputType.PaymentCard) {
      return MaskedTextInputFormatter(
        mask: 'xxxx xxxx xxxx xxxx',
        separator: ' ',
      );
    } else {
      return TextInputFormatter.withFunction((oldValue, newValue) => newValue);
    }
  }

  // text style for textinput
  TextStyle getTextStyle() {
    return TextStyle(
        fontSize: Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? FontSizes.size5
            : FontSizes.size10,
        color: widget.themeColor ?? Theme.of(context).primaryColor);
  }

  // input validations
  void checkValidation(String textFieldValue) {
    if (widget.inputType == InputType.Default) {
      //default
      _isValidate = textFieldValue.isNotEmpty;
      validationMessage = widget.errorMessage ?? 'Filed cannot be empty';
    } else if (widget.inputType == InputType.Email) {
      //email validation
      _isValidate = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(textFieldValue);
      validationMessage = widget.errorMessage ?? 'Email is not valid';
    } else if (widget.inputType == InputType.Number) {
      //contact number validation
      _isValidate = textFieldValue.length == widget.maxLength;
      validationMessage = widget.errorMessage ?? 'Contact Number is not valid';
    } else if (widget.inputType == InputType.Password) {
      //password validation
      // _isValidate = RegExp(
      //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      //     .hasMatch(textFieldValue);
      validationMessage = widget.errorMessage ?? 'Password is not valid';
    } else if (widget.inputType == InputType.PaymentCard) {
      //payment card validation
      _isValidate = textFieldValue.length == 19;
      validationMessage = widget.errorMessage ?? 'Card number is not correct';
    }
    oldTextSize = textFieldValue.length;
    //change value in state
    setState(() {});
  }

  // return input type for setting keyboard
  TextInputType getInputType() {
    switch (widget.inputType) {
      case InputType.Default:
        return TextInputType.text;

      case InputType.Email:
        return TextInputType.emailAddress;

      case InputType.Number:
        return TextInputType.number;

      case InputType.PaymentCard:
        return TextInputType.number;

      default:
        return TextInputType.text;
    }
  }

  // get max length of text
  int getMaxLength() {
    switch (widget.inputType) {
      case InputType.Default:
        return 15;

      case InputType.Email:
        return 15;

      case InputType.Number:
        return 12;

      case InputType.Password:
        return 15;

      case InputType.PaymentCard:
        return 19;

      default:
        return 15;
    }
  }

  // get prefix Icon
  Icon getPrefixIcon() {
    switch (widget.inputType) {
      case InputType.Default:
        return Icon(
          size: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? 7.sp
              : 23.sp,
          Icons.person,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        );

      case InputType.Email:
        return Icon(
          size: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? 7.sp
              : 23.sp,
          Icons.email,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        );

      case InputType.Number:
        return Icon(
          size: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? 7.sp
              : 23.sp,
          Icons.phone,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        );

      case InputType.Password:
        return Icon(
          size: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? 7.sp
              : 23.sp,
          Icons.lock,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        );

      case InputType.PaymentCard:
        return Icon(
          size: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? 7.sp
              : 23.sp,
          Icons.credit_card,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        );

      default:
        return Icon(
          size: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? 7.sp
              : 23.sp,
          Icons.person,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        );
    }
  }

  // get suffix icon
  Widget getSuffixIcon() {
    if (widget.inputType == InputType.Password) {
      return GestureDetector(
        onTap: () {
          visibility = !visibility;
          setState(() {});
        },
        child: Icon(
          size: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? 7.sp
              : 23.sp,
          visibility ? Icons.visibility : Icons.visibility_off,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        ),
      );
    } else {
      return Opacity(
          opacity: 0,
          child: Icon(
            Icons.phone,
            size: 23.sp,
          ));
    }
  }
}

//input types
enum InputType { Default, Email, Number, Password, PaymentCard }
