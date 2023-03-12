import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BottomIcon extends StatelessWidget {
  final IoniconsData icon;
  final String label;

  BottomIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 25,
          color: Colors.grey[200],
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }
}
