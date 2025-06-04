import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final String data;
  final IconData? icon;
  final Color? color;
  double? width;

  MyContainer({
    super.key,
    required this.data,
    this.icon,
    this.color,
    this.width,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color?.withValues(alpha: 0.1) ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color ?? Colors.grey),
      ),
      child: Row(
        children: [
            Icon(icon, color: color ?? Colors.grey),
            const SizedBox(width: 20,),
          Text(
            data,
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
