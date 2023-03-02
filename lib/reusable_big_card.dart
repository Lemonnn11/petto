import 'package:flutter/material.dart';
import 'constants.dart';

class ReusableBigCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/productdescription');
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 7,
          left: 2,
        ),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 155,
                      height: 115,
                      decoration: BoxDecoration(
                        color: kYellowColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 7, top: 5),
                  child: Text(
                    'Martin',
                    style: kTextCardNameStyle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7),
                  child: Text(
                    '(Nonthaburi, 26 km)',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7, top: 6),
                  child: Row(
                    children: [
                      Text(
                        '85\$',
                        style: TextStyle(
                            color: Color(0xff17A589),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 50),
                      Text(
                        'View detail',
                        style: TextStyle(
                            fontSize: 12.5,
                            decoration: TextDecoration.underline,
                            color: Colors.grey.shade600),
                      ),
                    ],
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
