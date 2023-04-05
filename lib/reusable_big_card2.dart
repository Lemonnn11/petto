import 'package:flutter/material.dart';
import 'package:petto/product_description.dart';
import 'constants.dart';

class ReusableBigCard2 extends StatelessWidget {
  final Widget image;
  final String name;
  static int color = 0;
  final String location;
  final String price;

  ReusableBigCard2(
      {required this.image,
      required this.name,
      required this.location,
      required this.price});

  Color getColor() {
    int color = ReusableBigCard2.color % 4;
    if (color == 0) {
      ReusableBigCard2.color += 1;
      return kYellowColor;
    } else if (color == 1) {
      ReusableBigCard2.color += 1;
      return kBlueColor;
    } else if (color == 2) {
      ReusableBigCard2.color += 1;
      return kRedColor;
    } else {
      ReusableBigCard2.color += 1;
      return Colors.teal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDescriptionpage(name: name),
          ),
        );
      },
      child: Container(
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: kPurpleColor,
                width: 1.5,
              )),
          child: Padding(
            padding: const EdgeInsets.only(left: 9, right: 9, bottom: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 9),
                      width: MediaQuery.of(context).size.width,
                      height: 115,
                      decoration: BoxDecoration(
                        color: getColor(),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Positioned(
                      top: -78,
                      left: -65,
                      child: Container(
                        width: 280,
                        height: 280,
                        child: image,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${price}\$',
                        style: TextStyle(
                            color: Color(0xff17A589),
                            fontWeight: FontWeight.bold),
                      ),
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
