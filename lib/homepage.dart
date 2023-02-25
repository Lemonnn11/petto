import 'package:flutter/material.dart';
import 'reusable_small_card.dart';
import 'constants.dart';
import 'reusable_big_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffdcefeb),
                Color(0xffdcefeb),
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
                Color(0x66FFB392),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // SizedBox(
                    //   width: 25,
                    // ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 19,
                              child: Image.asset('icons/menu.png'),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Welcome Back!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Pannavich',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  height: 18,
                                  child: Image.asset(
                                    'icons/waving-hand.png',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 0,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          width: 73,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 26,
                                child: Image.asset('icons/shopping-cart.png'),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              CircleAvatar(
                                backgroundImage: AssetImage('images/pup.png'),
                                backgroundColor: Colors.grey[300],
                                radius: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 38,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: kPurpleColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.8,
                              blurRadius: 0.8,
                            ),
                          ]),
                      width: 350,
                      height: 160,
                    ),
                    Positioned(
                      left: -27,
                      top: 150,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kYellowColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.75),
                              spreadRadius: 0.5,
                              blurRadius: 0.4,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 224,
                      top: 5,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kYellowColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 0.4,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        left: 219,
                        top: 143,
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(600, 300)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 0.5,
                              )
                            ],
                          ),
                        )),
                    Positioned(
                      top: 55,
                      left: 37,
                      child: Container(
                        width: 200,
                        child: Text(
                          'Find your best buddy here',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 138,
                      left: 39,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 7,
                          ),
                          child: Text(
                            'Find Now!',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16.5),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              spreadRadius: 1,
                              blurRadius: 1,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 173,
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Container(
                          child: Image.asset(
                            'images/cat_home.png',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0x66FFB392),
                Colors.white,
                Colors.white,
                Colors.white,
                Color(0x6688CFFF),
              ], begin: Alignment.topRight, end: Alignment.bottomLeft),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: ReusableSmallCard(
                              title: 'Dog',
                              color: kYellowColor,
                              icon: Icon(
                                FontAwesomeIcons.dog,
                                size: 20,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ReusableSmallCard(
                              title: 'Cats',
                              color: kGreenColor,
                              icon: Icon(
                                FontAwesomeIcons.cat,
                                size: 20,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: ReusableSmallCard(
                              title: 'Dog Stuffs',
                              color: kBlueColor,
                              icon: Icon(
                                FontAwesomeIcons.bone,
                                size: 20,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ReusableSmallCard(
                              title: 'Cats Stuffs',
                              color: kRedColor,
                              icon: Icon(
                                FontAwesomeIcons.fishFins,
                                size: 20,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Pets near you!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0x6688CFFF),
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 220,
                    margin: EdgeInsets.only(left: 12, right: 12),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ReusableBigCard(),
                        ReusableBigCard(),
                        ReusableBigCard(),
                        ReusableBigCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.shopping_cart,
      //       ),
      //       label: 'cart',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.ac_unit,
      //       ),
      //       label: 'unit',
      //       backgroundColor: Colors.blue,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.call,
      //       ),
      //       label: 'call',
      //     ),
      //   ],
      // ),
    );
  }
}
