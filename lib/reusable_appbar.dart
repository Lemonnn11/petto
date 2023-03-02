import 'package:flutter/material.dart';

class ReusableAppBar extends StatelessWidget {
  const ReusableAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
