import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.prefixIcon,
      required this.hintText,
      this.isPassword,
      this.controller,
      this.suffixIcon,
      this.textInputType,
      
      this.onChanged});

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool? isPassword;
  final TextEditingController? controller;
  final TextInputType? textInputType;

  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      obscureText: isPassword ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon:  prefixIcon,
          prefixIconColor: Coloors.greenColor,
          suffixIconColor: Coloors.greenColor,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1, color: Coloors.greyColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1, color: Coloors.greenColor))),
    );
  }
}
