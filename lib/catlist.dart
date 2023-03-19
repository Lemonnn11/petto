import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'constants.dart';
import 'reusable_big_card.dart';

class CatList extends StatefulWidget {
  const CatList({Key? key}) : super(key: key);

  @override
  State<CatList> createState() => _CatListState();
}

class _CatListState extends State<CatList> {

  final Reference firebaseStorage = FirebaseStorage.instance.ref();
  List<Map<String, String>> _petsList = [];
  final _firestore = FirebaseFirestore.instance;
  String? imgURL;
  void initState() {
    super.initState();
    _getPetsInfo();

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
          Column(
            children: [
              Container(
                height: 220,
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
            ],
          )
        ],

      ),

    );
  }
}
