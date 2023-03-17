import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class ProductDescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ProductDescriptionpage();
  }
}

class ProductDescriptionpage extends StatefulWidget {
  const ProductDescriptionpage({Key? key}) : super(key: key);

  @override
  State<ProductDescriptionpage> createState() => _ProductDescriptionpageState();
}

class _ProductDescriptionpageState extends State<ProductDescriptionpage> {
  List<Map<String, String>> _petsList = [];
  final _firestore = FirebaseFirestore.instance;

  void initState() {
    super.initState();
    _getPetsInfo();
  }

  void _getPetsInfo() async {
    int i = 0;
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
        _petsList.add(petsInfo!);
      }
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
                      top: -30,
                      left: 20,
                      child: Container(
                        width: 290,
                        height: 290,
                        child: Image(
                          image: AssetImage(
                            'images/dog2.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
