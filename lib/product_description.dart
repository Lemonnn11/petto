import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petto/owner_map.dart';
import 'constants.dart';
import 'package:ionicons/ionicons.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductDescriptionpage extends StatefulWidget {
  String? name;

  ProductDescriptionpage({required this.name});

  @override
  State<ProductDescriptionpage> createState() => _ProductDescriptionpageState();
}

class _ProductDescriptionpageState extends State<ProductDescriptionpage> {
  List<Map<String, String>> _petList = [];
  List<Map<String, String>> _petsList = [];
  final _firestore = FirebaseFirestore.instance;
  final Reference firebaseStorage = FirebaseStorage.instance.ref();
  String? imgURL;
  Map<String, String>? petInfo = {};

  void initState() {
    super.initState();
    _getPetsInfo();
    _getSinglePetInfo();
    _findPetsListIndex();
  }

  void _getPetsInfo() async {
    await for (var snapshot in _firestore.collection('pets').snapshots()) {
      for (var pet in snapshot.docs) {
        setState(() {
          final petData = pet.data();
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

  void _getSinglePetInfo() async {
    await for (var snapshot in _firestore.collection('pets').snapshots()) {
      for (var pet in snapshot.docs) {
        final petData = pet.data();
        if (petData['Name'].toString() == widget.name) {
          setState(() {
            petInfo!['Name'] = petData['Name'].toString();
            petInfo!['About'] = petData['About'].toString();
            petInfo!['Sex'] = petData['Sex'].toString();
            petInfo!['Age'] = petData['Age'].toString();
            petInfo!['Weight'] = petData['Weight'].toString();
            petInfo!['Price'] = petData['Price'].toString();
            petInfo!['Owner'] = petData['Owner'].toString();
            petInfo!['Location'] = petData['Location'].toString();
            petInfo!['Type'] = petData['Type'].toString();
            _petList.add(petInfo!);
          });
        }
      }
    }
  }

  Future<int?> _findPetsListIndex() async {
    int i = 0;
    await for (var snapshot in _firestore.collection('pets').snapshots()) {
      for (var pet in snapshot.docs) {
        final petData = pet.data();
        if (petData['Name'].toString() == widget.name) {
          return i;
        }
        i++;
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
    return Scaffold(
      body: ListView(
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
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
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
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 28,
                          child: Image.asset('icons/shopping-cart.png'),
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage('images/pup.png'),
                          backgroundColor: Colors.grey[300],
                          radius: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 40,
                      ),
                      width: 380,
                      height: 189,
                      decoration: BoxDecoration(
                        color: kYellowColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    Positioned(
                      top: -15,
                      left: 20,
                      child: Container(
                        width: 310,
                        height: 340,
                        child: FutureBuilder<String?>(
                          future: getImageData(petInfo!['Type'].toString(),
                              petInfo!['Name'].toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<String?> snapshot) {
                            if (snapshot.hasData) {
                              return Image.network(
                                snapshot.data.toString(),
                              );
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else {
                              return Text('Loading...');
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 14.0,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      FutureBuilder<int?>(
                        future: _findPetsListIndex(),
                        builder: (BuildContext context,
                            AsyncSnapshot<int?> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              _petsList[snapshot.data!]['Name'].toString() ??
                                  '',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else {
                            return Text('Loading...');
                          }
                        },
                      ),
                      FutureBuilder<int?>(
                        future: _findPetsListIndex(),
                        builder: (BuildContext context,
                            AsyncSnapshot<int?> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              (_petsList[snapshot.data!]['Price'].toString() ??
                                      '') +
                                  ' \$',
                              style: TextStyle(
                                  color: Color(0xff17A589),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else {
                            return Text('Loading...');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OwnerMap(name: widget.name),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'view location',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey[700],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 104,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: kPurpleColor,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xff6CCAB7),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FutureBuilder<int?>(
                                    future: _findPetsListIndex(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<int?> snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          (_petsList[snapshot.data!]['Age']
                                                      .toString() ??
                                                  '') +
                                              ' months',
                                          style: TextStyle(
                                              color: Color(0xff282828),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      } else {
                                        return Text('Loading...');
                                      }
                                    },
                                  ),
                                  Text(
                                    'Age',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xff43A1D7),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FutureBuilder<int?>(
                                  future: _findPetsListIndex(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<int?> snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        (_petsList[snapshot.data!]['Sex']
                                                .toString() ??
                                            ''),
                                        style: TextStyle(
                                            color: Color(0xff282828),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    } else {
                                      return Text('Loading...');
                                    }
                                  },
                                ),
                                Text(
                                  'Sex',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffF48579),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FutureBuilder<int?>(
                                    future: _findPetsListIndex(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<int?> snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          (_petsList[snapshot.data!]['Weight']
                                                      .toString() ??
                                                  '') +
                                              ' Kg',
                                          style: TextStyle(
                                              color: Color(0xff282828),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      } else {
                                        return Text('Loading...');
                                      }
                                    },
                                  ),
                                  Text(
                                    'Weight',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FutureBuilder<int?>(
                        future: _findPetsListIndex(),
                        builder: (BuildContext context,
                            AsyncSnapshot<int?> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              ('About ' +
                                      _petsList[snapshot.data!]['Name']
                                          .toString() ??
                                  ''),
                              style: TextStyle(
                                  color: Color(0xff282828),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else {
                            return Text('Loading...');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 3),
                  child: FutureBuilder<int?>(
                    future: _findPetsListIndex(),
                    builder:
                        (BuildContext context, AsyncSnapshot<int?> snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          (_petsList[snapshot.data!]['About'].toString() ?? ''),
                          style: TextStyle(
                            color: Color(0xff282828),
                            fontSize: 16,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        return Text('Loading...');
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Previous Owner',
                        style: TextStyle(
                          color: Color(0xff282828),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 114,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: kPurpleColor,
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 230,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: kYellowColor,
                                  backgroundImage:
                                      AssetImage('images/owner1.png'),
                                ),
                                SizedBox(
                                  width: 13,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 6,
                                    ),
                                    FutureBuilder<int?>(
                                      future: _findPetsListIndex(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<int?> snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            (_petsList[snapshot.data!]['Owner']
                                                    .toString() ??
                                                ''),
                                            style: TextStyle(
                                                color: Color(0xff36454F),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              snapshot.error.toString());
                                        } else {
                                          return Text('Loading...');
                                        }
                                      },
                                    ),
                                    FutureBuilder<int?>(
                                      future: _findPetsListIndex(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<int?> snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            (_petsList[snapshot.data!]
                                                        ['Location']
                                                    .toString() ??
                                                ''),
                                            style: TextStyle(
                                              color: Color(0xff36454F),
                                              fontSize: 13,
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              snapshot.error.toString());
                                        } else {
                                          return Text('Loading...');
                                        }
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: kYellowColor,
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: kYellowColor,
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: kYellowColor,
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: kYellowColor,
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: kYellowColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: kPurpleColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Ionicons.chatbubble_ellipses_outline,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 13.0, bottom: 31),
                  child: Container(
                    height: 66,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: kPurpleColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Adopt Me',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
