import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';

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
  bool _showErrorMessage = false;
  bool? _isChecked;

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
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: -45,
                      right: (MediaQuery.of(context).size.width / 2) - 141,
                      child: Container(
                        height: 160,
                        child: Image(
                          image: AssetImage('images/Pf2.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 110,
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
                      top: 140,
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
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      kGradientBlue,
                      Colors.white,
                      Colors.white,
                    ],
                    center: Alignment.centerLeft,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    width: 356,
                    height: 530,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: kPurpleColor,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, right: 25, left: 25, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, bottom: 4),
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, bottom: 4),
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
                            height: 46,
                            child: TextField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffECECEC),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(14)),
                              ),
                              onChanged: (value) {
                                _name = value;
                              },
                            ),
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
                            height: 46,
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffECECEC),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(14)),
                                errorText: _showErrorMessage
                                    ? 'Password does not match.'
                                    : null,
                              ),
                              onChanged: (value) {
                                _cpassword = value;
                                setState(() {
                                  if (_password != _cpassword) {
                                    _showErrorMessage = true;
                                  } else {
                                    _showErrorMessage = false;
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
                                  SizedBox(
                                    height: 17,
                                  ),
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
                                try {
                                  if (!_showErrorMessage) {
                                    final newUser = await _auth
                                        .createUserWithEmailAndPassword(
                                            email: _email, password: _password);
                                    if (newUser != null) {
                                      Navigator.pushNamed(context, '/home');
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
            ],
          ),
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  kGradientOrange,
                  Colors.white,
                ],
                center: Alignment.centerRight,
              ),
            ),
            height: 105,
            child: Image(
              image: AssetImage('images/pets.png'),
            ),
          ),
        ],
      ),
    );
  }
}
