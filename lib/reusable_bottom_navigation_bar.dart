import 'package:flutter/material.dart';
import 'reusable_bottom_icon.dart';
import 'constants.dart';
import 'package:ionicons/ionicons.dart';

class ReusableBottomNavigationBar extends StatelessWidget {
  const ReusableBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
                      Navigator.pushNamed(context, '/home');
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
    );
  }
}
