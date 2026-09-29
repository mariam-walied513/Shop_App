import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_new_app/core/utils/app_assets.dart';
import 'package:my_new_app/core/utils/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.readOnly,
    this.controller,
    this.onChanged,
    this.onTap,
  });

  final bool readOnly;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search any Product..',
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
         SvgPicture.asset(AppSvgs.search,
         width: 20,
         height: 20,
         fit: BoxFit. scaleDown,
        ),
        ),
      
        filled: true,
        fillColor: AppColors.white,
        border: InputBorder.none,
      ),
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}