import 'package:flutter/material.dart';

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
        body: ListView(
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
                              Container(
                                  height: 19,
                                  child: IconButton(
                                    icon:
                                        Icon(Icons.arrow_back_ios_new_outlined),
                                    onPressed: () {
                                      setState(() {
                                        xOffset = 0;
                                        yOffset = 0;
                                        isSideBarOpen = false;
                                      });
                                    },
                                  )),
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
                            width: 81,
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
                                    radius: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // SizedBox(
                      //   width: 25,
                      // ),
                      Row(
                        children: [
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
                            width: 81,
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
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      xOffset = 230;
                                    });
                                  },
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('images/pup.png'),
                                    backgroundColor: Colors.grey[300],
                                    radius: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
