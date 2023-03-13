import 'package:flutter/material.dart';
import 'constants.dart';

class ReusableBigCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String location;
  final String price;

  ReusableBigCard(
      {required this.imagePath,
      required this.name,
      required this.location,
      required this.price});

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
            padding: const EdgeInsets.only(left: 9, right: 9, bottom: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 9),
                      width: 155,
                      height: 115,
                      decoration: BoxDecoration(
                        color: kYellowColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Positioned(
                      top: -78,
                      left: -65,
                      child: Container(
                        width: 280,
                        height: 280,
                        child: Image.asset(imagePath),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 7, top: 5),
                  child: Text(
                    name,
                    style: kTextCardNameStyle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7),
                  child: Text(
                    location,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7, top: 6),
                  child: Row(
                    children: [
                      Text(
                        '${price}\$',
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
