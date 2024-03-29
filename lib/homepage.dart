import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'reusable_small_card.dart';
import 'constants.dart';
import 'reusable_big_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'reusable_bottom_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'reusable_bottom_navigation_bar.dart';
import 'log_event.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isSideBarOpen = false;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  Map<String, String> usersInfo = {};
  List<Map<String, String>> _petsList = [];
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool checkType = false;
  final Reference firebaseStorage = FirebaseStorage.instance.ref();
  String? imgURL;
  bool isGoogleSignIn = false;

  void initState() {
    super.initState();
    _getPetsInfo();
    _getUsersInfo();
  }

  Future<String?> _getCurrentUserEmail() async {
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

  Future<String?> _getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      final username = user?.displayName;
      if (user != null) {
        if (username == null) {
          loggedInUser = user;
          return loggedInUser?.email;
        } else {
          isGoogleSignIn = true;
          final fname = user?.displayName?.split(' ');
          return fname![0];
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  void _getPetsInfo() async {
    await for (var snapshot in _firestore.collection('pets').snapshots()) {
      for (var pet in snapshot.docs) {
        final petData = pet.data();
        setState(() {
          Map<String, String>? petsInfo = {};
          petsInfo['Name'] = petData['Name'].toString();
          petsInfo['About'] = petData['About'].toString();
          petsInfo['Sex'] = petData['Sex'].toString();
          petsInfo['Age'] = petData['Age'].toString();
          petsInfo['Weight'] = petData['Weight'].toString();
          petsInfo['Price'] = petData['Price'].toString();
          petsInfo['Owner'] = petData['Owner'].toString();
          petsInfo['Location'] = petData['Location'].toString();
          petsInfo['Type'] = petData['Type'].toString();
          _petsList.add(petsInfo!);
        });
      }
    }
  }

  void _getUsersInfo() async {
    await for (var snapshot in _firestore.collection('users').snapshots()) {
      for (var user in snapshot.docs) {
        setState(() {
          final userData = user.data();
          final userEmail = userData['email'];
          final userName = userData['name'];
          usersInfo![userEmail.toString()] = userName.toString();
        });
      }
    }
  }

  Future<String?> getImageData(String type, String imgName) async {
    try {
      if (type == 'Cat') {
        if (imgName != null) {
          try {
            final urlReference =
                firebaseStorage.child('Cats').child('${imgName}.png');
            imgURL = await urlReference.getDownloadURL();
            return imgURL.toString();
          } catch (e) {
            print(e);
          }
        }
      } else if (type == 'Dog') {
        if (imgName != null) {
          try {
            final urlReference =
                firebaseStorage.child('Dogs').child('${imgName}.png');
            imgURL = await urlReference.getDownloadURL();
            return imgURL.toString();
          } catch (e) {
            print(e);
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

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
                    kGradientGreen,
                    kGradientGreen,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    kGradientOrange,
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
                                          FutureBuilder<String?>(
                                            future: _getCurrentUser(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String?>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                if (isGoogleSignIn) {
                                                  return Text(
                                                    snapshot.data! ?? '',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  );
                                                } else {
                                                  loggedInUser =
                                                      _auth.currentUser;
                                                  return Text(
                                                    usersInfo?[
                                                            snapshot.data!] ??
                                                        '',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  );
                                                }
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    snapshot.error.toString());
                                              } else {
                                                return Text('Loading...');
                                              }
                                            },
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
                                            xOffset = 260;
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
                                          fontSize: 15.5,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          FutureBuilder<String?>(
                                            future: _getCurrentUser(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String?>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                if (isGoogleSignIn) {
                                                  return Text(
                                                    snapshot.data! ?? '',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  );
                                                } else {
                                                  loggedInUser =
                                                      _auth.currentUser;
                                                  return Text(
                                                    usersInfo?[
                                                            snapshot.data!] ??
                                                        '',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  );
                                                }
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    snapshot.error.toString());
                                              } else {
                                                return Text('Loading...');
                                              }
                                            },
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
                                    width: 76,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 28,
                                          child: Image.asset(
                                              'icons/shopping-cart.png'),
                                        ),
                                        Container(
                                          height: 28,
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
                          child: GestureDetector(
                            onTap: () async {
                              LogEvent log = LogEvent();
                              log.setAction('Look up all pets list');
                              final userEmail = await _getCurrentUserEmail();
                              log.setUserEmail(userEmail.toString());
                              log.addLog();
                              Navigator.pushNamed(context, '/petslist');
                            },
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
                    kGradientOrange,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    kGradientBlue,
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
                                child: GestureDetector(
                                  onTap: () async {
                                    LogEvent log = LogEvent();
                                    log.setAction('Look up dogs list');
                                    final userEmail =
                                        await _getCurrentUserEmail();
                                    log.setUserEmail(userEmail.toString());
                                    log.addLog();
                                    Navigator.pushNamed(context, '/doglist');
                                  },
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
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    LogEvent log = LogEvent();
                                    log.setAction('Look up cats list');
                                    final userEmail =
                                        await _getCurrentUserEmail();
                                    log.setUserEmail(userEmail.toString());
                                    log.addLog();
                                    Navigator.pushNamed(context, '/catlist');
                                  },
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
                      height: 5,
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
                        GestureDetector(
                          onTap: () async {
                            LogEvent log = LogEvent();
                            log.setAction('Look up all pets list');
                            final userEmail = await _getCurrentUserEmail();
                            log.setUserEmail(userEmail.toString());
                            log.addLog();
                            Navigator.pushNamed(context, '/petslist');
                          },
                          child: Text(
                            'view more',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.grey.shade600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                  ],
                ),
              ),
              Container(
                height: 236,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0x3388CFFF),
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                // child: SingleChildScrollView(
                //   child: Column(
                //     children: [
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   height: 220,
                // margin: EdgeInsets.only(left: 12, right: 12),
                // child:
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 12),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _petsList.length,
                    itemBuilder: (_, index) {
                      return ReusableBigCard(
                        image: FutureBuilder<String?>(
                          future: getImageData(
                              _petsList[index]['Type'].toString(),
                              _petsList[index]['Name'].toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<String?> snapshot) {
                            if (snapshot.hasData) {
                              return Image.network(snapshot.data.toString());
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else {
                              return Text('Loading...');
                            }
                          },
                        ),
                        name: _petsList[index]['Name'].toString(),
                        location: _petsList[index]['Location'].toString(),
                        price: _petsList[index]['Price'].toString(),
                      );
                    },
                  ),
                ),
                // ),
                //     ],
                //   ),
                // ),
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
        bottomNavigationBar: ReusableBottomNavigationBar(),
      ),
    );
  }
}
