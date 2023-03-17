import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petto/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';
  static int loggedInType = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                      ),
                      Positioned(
                        top: 30,
                        left: ((MediaQuery.of(context).size.width) / 2) - 40,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPurpleColor,
                          ),
                          width: 85,
                          height: 85,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image(
                              image: AssetImage('images/logo.png'),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 122,
                        left: ((MediaQuery.of(context).size.width) / 2) - 72,
                        child: Row(
                          children: [
                            Text(
                              'Hello',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            SizedBox(
                              width: 9,
                            ),
                            Text(
                              'Buddy!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: kPurpleColor),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 155,
                        left: ((MediaQuery.of(context).size.width) / 2) - 61,
                        child: Text(
                          'Sign in to Petto',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 356,
                    height: 395,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: kPurpleColor,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 22, horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, bottom: 4),
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, bottom: 4),
                            child: Text(
                              'Enter your email and password',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, bottom: 4),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800]),
                            ),
                          ),
                          Container(
                            width: 300,
                            height: 46,
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffECECEC),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(14)),
                              ),
                              onChanged: (value) {
                                _email = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, bottom: 4, top: 4),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800]),
                            ),
                          ),
                          Container(
                            width: 300,
                            height: 46,
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffECECEC),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(14)),
                              ),
                              onChanged: (value) {
                                _password = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 300,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  final user =
                                      await _auth.signInWithEmailAndPassword(
                                          email: _email, password: _password);
                                  print(user);
                                  if (user != null) {
                                    Navigator.pushNamed(context, '/home');
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kPurpleColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ))),
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 13.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 32,
                                ),
                                Text(
                                  'Don\'t have an account',
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/registration');
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                        color: Color(0xff6C3483),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      width: 300,
                      child: Divider(
                        height: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      loggedInType = 2;
                      GoogleSignInAccount? user = await GoogleSignIn().signIn();
                      GoogleSignInAuthentication? userAuth =
                          await user?.authentication;

                      AuthCredential credential = GoogleAuthProvider.credential(
                          accessToken: userAuth?.accessToken,
                          idToken: userAuth?.idToken);
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithCredential(credential);

                      if (userCredential != null) {
                        Navigator.pushNamed(context, '/home');
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(color: Color(0xff36454F), width: 1)),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(356, 60),
                      ),
                    ),
                    child: Container(
                      width: 300,
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Image(
                            image: AssetImage(
                              'images/google.png',
                            ),
                            width: 65,
                            height: 65,
                          ),
                          Text(
                            'Coutinue with Google',
                            style: TextStyle(
                                color: Color(0xff252525),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
