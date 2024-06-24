import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const Tag({
    super.key,
    required this.label,
    this.color = Colors.blue, // Default tag color
    this.textColor = Colors.white, // Default text color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0), // Rounded corners
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
