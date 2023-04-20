import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petto/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'constants.dart';
import 'log_event.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String _email = '';
  String _password = '';
  bool _showInvalidEmail = false;
  bool _showNullEmail = false;
  bool _showNullPw = false;
  bool _showIncorrectEmorPw = false;
  final RegExp emailic = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9.]+\.[a-zA-Z]{2,}$");

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
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                kGradientGreen,
                                kGradientGreen,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                        height: 180,
                        width: 200,
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  kGradientBlue,
                                  Colors.white,
                                  Colors.white,
                                  Colors.white,
                                  Colors.white,
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft),
                          ),
                          height: 180,
                          width: 200,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                      ),
                      Positioned(
                        top: 20,
                        left: ((MediaQuery.of(context).size.width) / 2) - 44,
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
                        top: 112,
                        left: ((MediaQuery.of(context).size.width) / 2) - 76,
                        child: Row(
                          children: [
                            Text(
                              'Hello',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            SizedBox(
                              width: 8,
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
                        top: 142,
                        left: ((MediaQuery.of(context).size.width) / 2) - 64,
                        child: Text(
                          'Sign in to Petto',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Positioned(
                        left: -50,
                        top: 30,
                        child: Container(
                          height: 150,
                          child: Transform.rotate(
                              angle: 70,
                              child: Image(
                                image: AssetImage('images/greycat.png'),
                              )),
                        ),
                      ),
                      Positioned(
                        right: -50,
                        top: 50,
                        child: Container(
                          height: 150,
                          child: Transform.rotate(
                            angle: 200,
                            child: Image(
                              image: AssetImage('images/orangecat.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 356,
                    height: 415,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: kPurpleColor,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
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
                            height: 70,
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: _showInvalidEmail
                                    ? OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(14),
                                      )
                                    : OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                errorText: _showInvalidEmail
                                    ? 'Please fill in an email address'
                                    : _showNullEmail
                                        ? 'Please fill in email'
                                        : null,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                filled: true,
                                fillColor: Color(0xffECECEC),
                              ),
                              onChanged: (value) {
                                _email = value;
                                setState(() {
                                  if (_email == '') {
                                    _showNullEmail = true;
                                    _showInvalidEmail = false;
                                  } else {
                                    if (!emailic.hasMatch(value)) {
                                      _showInvalidEmail = true;
                                    } else {
                                      _showInvalidEmail = false;
                                      _showNullEmail = false;
                                    }
                                  }
                                });
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
                            height: 70,
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                errorText: _showNullPw
                                    ? 'Please fill in password'
                                    : _showIncorrectEmorPw
                                        ? 'incorrect email or password'
                                        : null,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
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
                            height: 7,
                          ),
                          Container(
                            width: 300,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_email == '' && _password == '') {
                                  setState(() {
                                    _showNullEmail = true;
                                    _showNullPw = true;
                                  });
                                } else if (_email == '' || _password == '') {
                                  if (_email == '') {
                                    setState(() {
                                      _showNullEmail = true;
                                    });
                                  }
                                  if (_password == '') {
                                    setState(() {
                                      _showNullPw = true;
                                    });
                                  }
                                } else {
                                  try {
                                    final user =
                                        await _auth.signInWithEmailAndPassword(
                                            email: _email, password: _password);
                                    if (user != null) {
                                      LogEvent log = LogEvent();
                                      log.setAction(
                                          'Signed in by email&password');
                                      final userEmail = await _getCurrentUser();
                                      log.setUserEmail(userEmail.toString());
                                      log.addLog();
                                      Navigator.pushNamed(context, '/home');
                                    }
                                  } catch (e) {
                                    print(e);
                                    setState(() {
                                      _showIncorrectEmorPw = true;
                                      _showNullPw = false;
                                    });
                                  }
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
                            padding: const EdgeInsets.only(top: 11.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Or',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 178,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          kGradientOrange,
                          Colors.white,
                        ],
                        center: Alignment.bottomLeft,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 26.0, left: 26),
                          child: ElevatedButton(
                            onPressed: () async {
                              GoogleSignInAccount? user =
                                  await GoogleSignIn().signIn();
                              GoogleSignInAuthentication? userAuth =
                                  await user?.authentication;

                              AuthCredential credential =
                                  GoogleAuthProvider.credential(
                                      accessToken: userAuth?.accessToken,
                                      idToken: userAuth?.idToken);
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithCredential(credential);

                              if (userCredential != null) {
                                LogEvent log = LogEvent();
                                log.setAction('Signed in by google');
                                final userEmail = await _getCurrentUser();
                                log.setUserEmail(userEmail.toString());
                                log.addLog();
                                Navigator.pushNamed(context, '/home');
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                      color: Color(0xff36454F), width: 1)),
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
                        ),
                        Positioned(
                          bottom: -30,
                          right: 65,
                          child: Container(
                            height: 160,
                            child: Image(
                              image: AssetImage('images/Puppyfootto.png'),
                            ),
                          ),
                        ),
                      ],
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
