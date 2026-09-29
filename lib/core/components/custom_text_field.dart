import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_new_app/core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    this.onSuffixPressed,
    this.suffixIcon,
    this.obscureText = false,
  });

  final String hint;

  final Widget prefixIcon;
  final TextEditingController controller;
  final void Function()? onSuffixPressed;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.black,
        fontWeight: FontWeight.w300,
      ),
      obscureText: obscureText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        prefixIcon: Padding(padding: REdgeInsets.all(16.0), child: prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: onSuffixPressed, icon: suffixIcon!)
            : null,
        hintText: hint,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w200,
          fontSize: 14.sp,
          color: AppColors.grey,
        ),
        fillColor: Colors.white,
        filled: true,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
      ),
    );
  }
}