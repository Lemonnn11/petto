import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  bool isEmailEmpty = false;

  Future<String?> _getCurrentUser() async {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('images/pup.png'),
              backgroundColor: Colors.grey[300],
              radius: 25,
            ),
            title: Text('Pannavich'),
            subtitle: FutureBuilder<String?>(
                future: _getCurrentUser(),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Text('Loading...');
                  }
                }),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              _auth.signOut();
              Navigator.pushNamed(context, '/login');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40,
                ),
                Icon(
                  Icons.logout_outlined,
                  color: Colors.grey[600],
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Sign Out'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
