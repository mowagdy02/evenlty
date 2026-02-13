import 'package:evently/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  bool? filled;
  Color? fillColor;
  Color borderColor;
  Widget? prefixIcon;
  Widget? suffixIcon;
  String? hintText;
  String?labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  bool obscureText;
  int? maxLines;
  String? initialValue;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
   CustomTextField({
     super.key,
     this.filled,
     this.fillColor,
     required this.borderColor,
     this.prefixIcon,
     this.suffixIcon,
     this.hintText,
     this.hintStyle,
     this.labelText,
     this.labelStyle,
     this.obscureText = false,
     this.maxLines = 1,
     this.controller,
     this.onChanged,
     this.validator,
     this.initialValue,
   });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon:prefixIcon ,
        suffixIcon: suffixIcon,
        enabledBorder: outlineInputBorder(16,borderColor),
        focusedBorder: outlineInputBorder(16,borderColor),
        focusedErrorBorder: outlineInputBorder(16, AppColors.red) ,
        errorBorder:  outlineInputBorder(16, AppColors.red),
        filled:filled ,
        fillColor: fillColor,
        hintText:hintText ,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,

      ),
    );
  }
  OutlineInputBorder outlineInputBorder(double radius, Color borderColor){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color: borderColor,
        width: 1
      ),
    );
  }
}
