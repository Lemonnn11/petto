import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';
import 'log_event.dart';

class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String _email = '';
  String _password = '';
  String _cpassword = '';
  String _name = '';
  bool _showPwNotmatch = false;
  bool _showInvalidUsername = false;
  bool _showNullUsername = false;
  bool _showInvalidEmail = false;
  bool _showNullEmail = false;
  bool _showNullPw = false;
  bool _showNullCPw = false;
  bool? _isChecked;
  bool? _isUsernameExist = false;
  bool? _isEmailExist = false;
  List<Map<String, String>> _usersList = [];
  final RegExp alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
  final RegExp emailic = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9.]+\.[a-zA-Z]{2,}$");

  void initState() {
    super.initState();
    _getUsersInfo();
  }

  bool isAllValid() {
    print('not match ' + _showPwNotmatch.toString());
    print('invalid username ' + _showInvalidUsername.toString());
    print('invalid email ' + _showInvalidEmail.toString());
    print('null username ' + _showNullUsername.toString());
    print('null email ' + _showNullEmail.toString());
    print('null pw ' + _showNullPw.toString());
    print('null cpw ' + _showNullCPw.toString());
    print('checked ' + _isChecked.toString());
    if (!_showPwNotmatch &&
        !_showInvalidUsername &&
        !_showNullUsername &&
        !_showInvalidEmail &&
        !_showNullPw &&
        !_showNullCPw &&
        !_showNullEmail &&
        _isChecked!) {
      return true;
    } else {
      if (_showNullEmail == true ||
          _showNullUsername == true ||
          _showNullPw == true ||
          _showNullCPw == true) {
        setState(() {
          _showInvalidEmail = false;
          _showInvalidUsername = false;
          _showPwNotmatch = false;
          _showNullPw = true;
        });
      }
      return false;
    }
  }

  void _getUsersInfo() async {
    await for (var snapshot in _firestore.collection('users').snapshots()) {
      for (var user in snapshot.docs) {
        final userData = user.data();
        Map<String, String>? userInfo = {};
        userInfo['name'] = userData['name'].toString();
        userInfo['email'] = userData['email'].toString();
        _usersList.add(userInfo!);
      }
    }
  }

  void _isUsernameExistt(String name) {
    for (var user in _usersList) {
      if (user['name'] == name) {
        setState(() {
          _isUsernameExist = true;
        });
      }
    }
  }

  void _isEmailExistt(String email) {
    for (var user in _usersList) {
      if (user['email'] == email) {
        setState(() {
          _isEmailExist = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      kGradientGreen,
                      kGradientGreen,
                      kGradientGreen,
                      Colors.white,
                    ],
                    center: Alignment.centerLeft,
                  ),
                ),
                height: 189,
                child: Stack(
                  children: [
                    Positioned(
                      top: -30,
                      right: (MediaQuery.of(context).size.width / 2) - 141,
                      child: Container(
                        height: 160,
                        child: Image(
                          image: AssetImage('images/Pf2.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 115,
                      left: (MediaQuery.of(context).size.width / 2) - 110,
                      child: Text(
                        'Create an account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 143,
                      left: (MediaQuery.of(context).size.width / 2) - 142,
                      child: Text(
                        'Join to find your suitable buddy here!',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(colors: [
                        kGradientBlue,
                        Colors.white,
                        Colors.white,
                      ], center: Alignment.centerRight),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        width: 356,
                        height: 605,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: kPurpleColor,
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 9, right: 25, left: 25, bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 4),
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 4),
                                child: Text(
                                  'Username',
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
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    errorText: _showInvalidUsername
                                        ? 'Username can contain only a-z and No.'
                                        : _showNullUsername
                                            ? 'Please fill in username'
                                            : _isUsernameExist!
                                                ? 'Username is taken, Try again'
                                                : null,
                                    border: _showInvalidUsername
                                        ? OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          )
                                        : OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    filled: true,
                                    fillColor: Color(0xffECECEC),
                                  ),
                                  onChanged: (value) {
                                    _name = value;

                                    setState(() {
                                      _isUsernameExistt(_name);
                                      if (_name == '') {
                                        _showNullUsername = true;
                                      }
                                      if (!alphanumeric.hasMatch(value)) {
                                        _showInvalidUsername = true;
                                      } else {
                                        _showInvalidUsername = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 4),
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
                                    errorText: _showInvalidEmail
                                        ? 'Please fill in email address'
                                        : _showNullEmail
                                            ? 'Please fill in email'
                                            : _isEmailExist!
                                                ? 'Email is taken, Try again'
                                                : null,
                                    border: _showInvalidEmail
                                        ? OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          )
                                        : OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    filled: true,
                                    fillColor: Color(0xffECECEC),
                                  ),
                                  onChanged: (value) {
                                    _email = value;
                                    setState(() {
                                      _isEmailExistt(_email);
                                      if (_email == '') {
                                        _showNullEmail = true;
                                      }
                                      if (!emailic.hasMatch(value)) {
                                        _showInvalidEmail = true;
                                      } else {
                                        _showInvalidEmail = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 4),
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
                                        : null,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    filled: true,
                                    fillColor: Color(0xffECECEC),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _password = value;
                                    setState(() {
                                      if (_password == '') {
                                        _showNullPw = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, bottom: 4, top: 4),
                                child: Text(
                                  'Confirmed Password',
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
                                    errorText: _showPwNotmatch
                                        ? 'Password does not match'
                                        : _showNullCPw
                                            ? 'Please confirm password'
                                            : null,
                                    // errorBorder: _showPwNotmatch
                                    //     ? OutlineInputBorder(
                                    //         borderSide: BorderSide(
                                    //           color: Colors.red,
                                    //           width: 1.5,
                                    //         ),
                                    //         borderRadius:
                                    //             BorderRadius.circular(14),
                                    //       )
                                    //     : OutlineInputBorder(
                                    //         borderSide: BorderSide.none,
                                    //         borderRadius:
                                    //             BorderRadius.circular(14),
                                    //       ),
                                    filled: true,
                                    fillColor: Color(0xffECECEC),
                                    border: _showPwNotmatch
                                        ? OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          )
                                        : OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                  ),
                                  onChanged: (value) {
                                    _cpassword = value;
                                    setState(() {
                                      if (_cpassword == '') {
                                        _showNullCPw = true;
                                      }
                                      if (_password != value) {
                                        _showPwNotmatch = true;
                                      } else {
                                        _showPwNotmatch = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _isChecked ?? false,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked = value;
                                      });
                                    },
                                    activeColor: kPurpleColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'I agree to Petto\'s Terms of Service\n and Privacy Policy',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              Container(
                                width: 300,
                                height: 46,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_name == '' &&
                                        _email == '' &&
                                        _password == '' &&
                                        _cpassword == '') {
                                      setState(() {
                                        _showNullUsername = true;
                                        _showNullEmail = true;
                                        _showNullPw = true;
                                        _showNullCPw = true;
                                      });
                                    } else if (_name == '' ||
                                        _email == '' ||
                                        _password == '' ||
                                        _cpassword == '') {
                                      if (_name == '') {
                                        setState(() {
                                          _showNullUsername = true;
                                        });
                                      }
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
                                      if (_cpassword == '') {
                                        setState(() {
                                          _showNullCPw = true;
                                        });
                                      }
                                    } else {
                                      try {
                                        print(isAllValid);
                                        if (isAllValid()) {
                                          final newUser = await _auth
                                              .createUserWithEmailAndPassword(
                                                  email: _email,
                                                  password: _password);
                                          if (newUser != null) {
                                            LogEvent log = LogEvent();
                                            log.setAction(
                                                'Signed in by email&password');
                                            log.setUserEmail(_email);
                                            log.addLog();
                                            Navigator.pushNamed(
                                                context, '/home');
                                          }
                                        } else {}
                                      } on FirebaseException catch (e) {
                                        if (e.code == 'weak') {}
                                      } catch (e) {
                                        print(e);
                                      }
                                      _firestore.collection('users').add({
                                        'email': _email,
                                        'name': _name,
                                      });
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
                                    'Sign up',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already a Petto\'s member?',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    child: Text(
                                      'Sign in',
                                      style: TextStyle(
                                          color: Color(0xff6C3483),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       colors: [
                  //         kGradientBlue,
                  //         Colors.white,
                  //         Colors.white,
                  //       ],
                  //       begin: Alignment.topRight,
                  //       end: Alignment.bottomLeft,
                  //     ),
                  //   ),
                  //   height: 84,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Image(
                  //     image: AssetImage('images/pets.png'),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
