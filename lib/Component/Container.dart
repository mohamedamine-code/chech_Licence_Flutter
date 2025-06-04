import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final String data;
  String? value;
  final IconData? icon;
  final Color? color;
  double? width;
  double? height;

  MyContainer({
    this.value,
    super.key,
    required this.data,
    this.icon,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color?.withValues(alpha: 0.1) ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color ?? Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon, color: color ?? Colors.grey),

          Text(
            data,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color ?? Colors.black87,
            ),
          ),
          Text(
            value ?? "",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
