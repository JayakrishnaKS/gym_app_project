import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../Authentication/Login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
    storageBucket: "gym-app-f5d38.appspot.com",
      apiKey: "AIzaSyAa0pH-hQ0dSbc8s7vay2rQvkRi-WyUbjk",
      appId: "1:630772895305:android:575e11bc9c6e851309f998",
      messagingSenderId:'',
      projectId: "gym-app-f5d38"));
  runApp(MaterialApp(
    home: splashPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class splashPage extends StatefulWidget {
  const splashPage({super.key});

  @override
  State<splashPage> createState() => _splashPageState();
}

class _splashPageState extends State<splashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => loginPage()));
    });
    //  Timer(Duration, (seconds:5)() { })
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF568896), //Color(0xFF473F97),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Lottie.asset(
            "assets/animation/Animation - 1698747719171.json",
            height: 300,
            width: 300,
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            "Gym App",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            "Get Fit With Us",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.white70),
          )
        ]),
      ),
    );
  }
}