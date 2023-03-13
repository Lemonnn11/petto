import 'package:flutter/material.dart';

class ReusableSideBarTab extends StatelessWidget {
  final IconData icon;
  final String text;

  ReusableSideBarTab({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 35,
        ),
        Icon(
          icon,
          color: Colors.grey[800],
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 17),
        ),
      ],
    );
  }
}
