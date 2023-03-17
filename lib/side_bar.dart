import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reusable_side_bar_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  final _firestore = FirebaseFirestore.instance;
  Map<String, String>? usersInfo = {};
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool checkType = false;

  void initState() {
    super.initState();
    _getUsersInfo();
    _checkLoggedInType();
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

  Future<String?> _getCurrentUserDisplayName() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        List<UserInfo>? userInfo = loggedInUser?.providerData;
        return userInfo?.elementAt(0).displayName;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> _getCurrentUserProviderID() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        List<UserInfo>? userInfo = loggedInUser?.providerData;
        return userInfo?.elementAt(0).providerId;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _checkLoggedInType() async {
    String? providerID = await _getCurrentUserProviderID();
    try {
      if (providerID == 'google.com') {
        print('google');
        setState(() {
          checkType = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 11.0),
      child: Container(
        color: Colors.white,
        width: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              title: checkType
                  ? FutureBuilder<String?>(
                      future: _getCurrentUserDisplayName(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String?> snapshot) {
                        if (snapshot.hasData) {
                          loggedInUser = _auth.currentUser;
                          return Text(
                            snapshot.data! ?? '',
                            style: TextStyle(fontSize: 18),
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          return GestureDetector(
                            child: Text('Sign In'),
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                          );
                        }
                      })
                  : FutureBuilder<String?>(
                      future: _getCurrentUser(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String?> snapshot) {
                        if (snapshot.hasData) {
                          loggedInUser = _auth.currentUser;
                          return Text(
                            usersInfo?[snapshot.data!] ?? '',
                            style: TextStyle(fontSize: 18),
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          return GestureDetector(
                            child: Text('Sign In'),
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                          );
                        }
                      }),
              subtitle: FutureBuilder<String?>(
                  future: _getCurrentUser(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!,
                        style: TextStyle(fontSize: 15),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return Text('Loading...');
                    }
                  }),
            ),
            SizedBox(
              height: 25,
            ),
            ReusableSideBarTab(
              icon: Icons.account_circle_outlined,
              text: 'My Account',
            ),
            SizedBox(
              height: 30,
            ),
            ReusableSideBarTab(
              icon: Icons.support_agent_sharp,
              text: 'Support',
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                if (checkType!) {
                  await googleSignIn.signOut();
                } else {
                  await _auth.signOut();
                }
                Navigator.pushNamed(context, '/login');
              },
              child: ReusableSideBarTab(
                icon: Icons.logout_outlined,
                text: 'Sign Out',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
