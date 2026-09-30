import 'package:flutter/material.dart';

class OrderTab extends StatelessWidget {
  final String title;
  final bool selected;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const OrderTab({
    super.key,
    required this.title,
    required this.selected,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 27,
        decoration: BoxDecoration(
          color: selected ? activeColor : inactiveColor,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : activeColor,
          ),
        ),
      ),
    );
  }
}