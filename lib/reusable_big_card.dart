import 'package:flutter/material.dart';
import 'package:petto/product_description.dart';
import 'constants.dart';

class ReusableBigCard extends StatelessWidget {
  final Widget image;
  final String name;
  final String location;
  final String price;

  ReusableBigCard(
      {required this.image,
      required this.name,
      required this.location,
      required this.price});

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
        margin: EdgeInsets.only(
          right: 7,
          left: 2,
        ),
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
                  width: 148,
                  margin: EdgeInsets.only(left: 7),
                  child: Text(
                    location,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
                    softWrap: true,
                  ),
                ),
                Container(
                  width: 145,
                  margin: EdgeInsets.only(left: 7, top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      price == 'Free'
                          ? Text(
                              '${price}',
                              style: TextStyle(
                                  color: Color(0xff17A589),
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
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
