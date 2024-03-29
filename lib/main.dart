import 'package:flutter/material.dart';
import 'package:petto/catlist.dart';
import 'package:petto/petslist.dart';
import 'product_description.dart';
import 'registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:petto/sign_in.dart';
import 'package:petto/doglist.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/home': (context) => Home(),
        '/registration': (context) => Registration(),
        '/login': (context) => Login(),
        '/catlist': (context) => CatList(),
        '/doglist': (context) => DogList(),
        '/petslist': (context) => PetsList(),
      },
    );
  }
}
