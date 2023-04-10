import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petto/reusable_bottom_navigation_bar.dart';
import 'constants.dart';
import 'reusable_big_card2.dart';

class DogList extends StatefulWidget {
  const DogList({Key? key}) : super(key: key);

  @override
  State<DogList> createState() => _DogListState();
}

class _DogListState extends State<DogList> {
  final Reference firebaseStorage = FirebaseStorage.instance.ref();
  List<Map<String, String>> _dogsList = [];
  final _firestore = FirebaseFirestore.instance;
  String? imgURL;

  void initState() {
    super.initState();
    _getPetsInfo();
  }

  void _getPetsInfo() async {
    await for (var snapshot in _firestore.collection('pets').snapshots()) {
      for (var pet in snapshot.docs) {
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
        setState(() {
          if (petData['Type'].toString() == 'Dog') {
            _dogsList.add(petsInfo);
          }
        });
      }
    }
  }

  Future<String?> getImageData(String imgName) async {
    try {
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
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                kGradientYellow,
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
                kGradientYellow,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Padding(
                      padding: EdgeInsets.only(left: 35.0),
                      child: Text(
                        'Cat Category',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff8E44AD),
                            fontWeight: FontWeight.w900),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0,
                        mainAxisExtent: 236),
                    itemCount: _dogsList.length,
                    itemBuilder: (_, index) {
                      return ReusableBigCard2(
                        image: FutureBuilder<String?>(
                          future:
                              getImageData(_dogsList[index]['Name'].toString()),
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
                        name: _dogsList[index]['Name'].toString(),
                        location: _dogsList[index]['Location'].toString(),
                        price: _dogsList[index]['Price'].toString(),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.add),
        backgroundColor: Color(0xff6CCAB7),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ReusableBottomNavigationBar(),
    );
  }
}
