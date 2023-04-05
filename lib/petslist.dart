import 'package:flutter/material.dart';
import 'constants.dart';
import 'reusable_bottom_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petto/reusable_long_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PetsList extends StatefulWidget {
  const PetsList({Key? key}) : super(key: key);

  @override
  State<PetsList> createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  final _firestore = FirebaseFirestore.instance;
  List<Map<String, String>> _petsList = [];
  final Reference firebaseStorage = FirebaseStorage.instance.ref();
  String? imgURL;
  double? listViewLength;

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
        petsInfo['Des'] = petData['Des'].toString();
        setState(() {
          _petsList.add(petsInfo!);
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            kGradientBlue,
            Colors.white,
            Colors.white,
            Colors.white,
            kGradientOrange,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          color: Colors.white,
        ),
        child: ListView(
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
              padding: EdgeInsets.only(left: 50.0, top: 13),
              child: Text(
                'Find your nearest Buddy!',
                style: TextStyle(
                    fontSize: 21,
                    color: Color(0xff8E44AD),
                    fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: _petsList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 15.0,
                      right: 15,
                      left: 15,
                    ),
                    child: ReusableLongCard(
                      image: FutureBuilder<String?>(
                        future: getImageData(
                            _petsList[index]['Type'].toString(),
                            _petsList[index]['Name'].toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<String?> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              child: Image.network(
                                snapshot.data.toString(),
                                width: 800,
                                height: 600,
                                fit: BoxFit.cover,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else {
                            return Text('Loading...');
                          }
                        },
                      ),
                      name: _petsList[index]['Name'].toString(),
                      location: _petsList[index]['Location'].toString(),
                      des: _petsList[index]['Des'].toString(),
                      price: _petsList[index]['Price'].toString(),
                    ),
                  );
                },
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
      bottomNavigationBar: ReusableBottomNavigationBar(),
    );
  }
}
