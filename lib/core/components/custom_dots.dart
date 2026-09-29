import 'package:flutter/material.dart';
import 'package:my_new_app/core/utils/app_colors.dart';

class CustomDots extends StatefulWidget {
  const CustomDots({super.key, required this.count});
  final int count;

  @override
  State<CustomDots> createState() => _CustomDotsState();
}

class _CustomDotsState extends State<CustomDots> {
  final Color selectedColor = AppColors.black;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for(int i=0; i<widget.count; i++)
          if(currentIndex == i)
            Container(
              height: 10,
              width: 40,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: AppColors.black,
                borderRadius: BorderRadius.circular(20)
              ),
            )
            else
          Container(
            height: 10,
            width: 10,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: AppColors.grey,
              shape: BoxShape.circle
            ),
          )
      ],
    );
  }
}