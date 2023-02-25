import 'package:flutter/material.dart';

class ReusableSmallCard extends StatelessWidget {
  final String? title;
  final Color? color;
  final Icon? icon;

  ReusableSmallCard({this.title, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 13.0,
            vertical: 2.0,
          ),
          child: Container(
            height: 50,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: icon,
                ),
                SizedBox(
                  width: 13,
                ),
                Text(
                  title.toString(),
                  style: TextStyle(
                    fontSize: 15.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
