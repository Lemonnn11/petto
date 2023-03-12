import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'reusable_small_card.dart';
import 'constants.dart';
import 'reusable_big_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'reusable_bottom_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isSideBarOpen = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 250),
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: ListView(
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
                    isSideBarOpen
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // SizedBox(
                              //   width: 25,
                              // ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            xOffset = 0;
                                            isSideBarOpen = false;
                                          });
                                        },
                                        child: CircleAvatar(
                                          child: Icon(
                                            Icons.arrow_back_ios_new_outlined,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                          backgroundColor: kPurpleColor,
                                          radius: 19,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 22,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    width: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 26,
                                          child: Image.asset(
                                              'icons/shopping-cart.png'),
                                        ),
                                        Container(
                                          height: 26,
                                          child:
                                              Image.asset('icons/search.png'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // SizedBox(
                              //   width: 25,
                              // ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            xOffset = 230;
                                            isSideBarOpen = true;
                                          });
                                        },
                                        child: CircleAvatar(
                                          backgroundImage:
                                              AssetImage('images/pup.png'),
                                          backgroundColor: Colors.grey[300],
                                          radius: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                width: 11,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    width: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 26,
                                          child: Image.asset(
                                              'icons/shopping-cart.png'),
                                        ),
                                        Container(
                                          height: 26,
                                          child:
                                              Image.asset('icons/search.png'),
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
                            top: 30,
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
                          left: 230,
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
                            left: 223,
                            top: 137,
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.purple[100],
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(600, 300)),
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
                          left: 27,
                          child: Container(
                            width: 200,
                            child: Text(
                              'Find your best buddy with Petto!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
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
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.5),
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
                          top: -4,
                          left: 178,
                          child: Container(
                            width: 200,
                            height: 200,
                            child: Image.asset(
                              'images/cat_home.png',
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
                      height: 15,
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
                      height: 3,
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
                      height: 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // SizedBox(
                        //   width: 25,
                        // ),
                        Text(
                          'Pets near you!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Text(
                          'view more',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.grey.shade600),
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
                        height: 10,
                      ),
                      Container(
                        height: 220,
                        margin: EdgeInsets.only(left: 12, right: 12),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SizedBox(
                              width: 4,
                            ),
                            ReusableBigCard(
                              imagePath: 'images/dog1.png',
                              imageHeight: 280,
                              imageWidth: 280,
                            ),
                            ReusableBigCard(
                              imagePath: 'images/dog2.png',
                              imageHeight: 280,
                              imageWidth: 280,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(FontAwesomeIcons.add),
          backgroundColor: Color(0xff6CCAB7),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 5,
          shape: CircularNotchedRectangle(),
          color: kPurpleColor,
          child: Container(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 170,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: BottomIcon(
                          icon: Ionicons.home_outline,
                          label: 'Home',
                        ),
                      ),
                      BottomIcon(
                        icon: Ionicons.heart_outline,
                        label: 'Wish List',
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 170,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BottomIcon(
                        icon: Ionicons.chatbubble_ellipses_outline,
                        label: 'Chat',
                      ),
                      BottomIcon(
                        icon: Ionicons.settings_outline,
                        label: 'Setting',
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
