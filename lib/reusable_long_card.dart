import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:ionicons/ionicons.dart';
import 'package:petto/product_description.dart';
import 'log_event.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReusableLongCard extends StatefulWidget {
  final Widget image;
  static int color = 0;
  final String name;
  final String location;
  final String des;
  final String price;

  ReusableLongCard(
      {required this.image,
      required this.name,
      required this.location,
      required this.price,
      required this.des});

  @override
  State<ReusableLongCard> createState() => _ReusableLongCardState();
}

class _ReusableLongCardState extends State<ReusableLongCard> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

  Future<String?> _getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        return loggedInUser?.email;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Color getColor() {
    int color = ReusableLongCard.color % 4;
    if (color == 0) {
      ReusableLongCard.color += 1;
      return kYellowColor;
    } else if (color == 1) {
      ReusableLongCard.color += 1;
      return kBlueColor;
    } else if (color == 2) {
      ReusableLongCard.color += 1;
      return kRedColor;
    } else {
      ReusableLongCard.color += 1;
      return Colors.teal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 18,
          child: GestureDetector(
            onTap: () async {
              LogEvent log = LogEvent();
              log.setAction('Look up pet named ${widget.name}');
              final userEmail = await _getCurrentUser();
              log.setUserEmail(userEmail.toString());
              log.addLog();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDescriptionpage(name: widget.name),
                ),
              );
            },
            child: Container(
              width: 382,
              height: 157,
              decoration: BoxDecoration(
                border: Border.all(
                  color: kPurpleColor,
                  width: 2.0,
                ),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 170,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 190,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Icon(
                                Ionicons.heart_outline,
                                size: 20,
                                color: Color(0xff8E44AD),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          widget.location,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            widget.des,
                            style: TextStyle(fontSize: 12),
                            softWrap: true,
                          ),
                        ),
                        Container(
                          width: 190,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                widget.price == 'Free'
                                    ? Text(
                                        '${widget.price}',
                                        style: TextStyle(
                                          color: Color(0xff17A589),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      )
                                    : Text(
                                        '${widget.price}\$',
                                        style: TextStyle(
                                          color: Color(0xff17A589),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                Text(
                                  'View detail',
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      decoration: TextDecoration.underline,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            LogEvent log = LogEvent();
            log.setAction('Look up pet named ${widget.name}');
            final userEmail = await _getCurrentUser();
            log.setUserEmail(userEmail.toString());
            log.addLog();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDescriptionpage(name: widget.name),
              ),
            );
          },
          child: Container(
            width: 155,
            height: 180,
            decoration: BoxDecoration(
                color: getColor(),
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      -1.0, // Move to right 5  horizontally
                      0.0, // Move to bottom 5 Vertically
                    ),
                  ),
                ]),
            child: widget.image,
          ),
        ),
      ],
    );
  }
}
