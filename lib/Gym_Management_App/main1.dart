import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym/Gym_Management_App/bottom_nav.dart';
import 'package:gym/Gym_Management_App/controller/bottomnav_controller.dart';
import 'package:gym/Gym_Management_App/splash%20screen/splash.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
      storageBucket: "gym-app-f5d38.appspot.com",
      apiKey: "AIzaSyAa0pH-hQ0dSbc8s7vay2rQvkRi-WyUbjk",
      appId: "1:630772895305:android:575e11bc9c6e851309f998",
      messagingSenderId: '',
      projectId: "gym-app-f5d38"));
  runApp(mainn());
}
class mainn extends StatefulWidget {

  @override
  State<mainn> createState() => _mainState();
}

class _mainState extends State<mainn> {
  User? user=FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>BottomNavController(),child: MaterialApp(debugShowCheckedModeBanner: false,
      home: user==null?splashPage():BottomNav(),
    ),);
    // return MaterialApp(debugShowCheckedModeBanner: false,
    //   home: user==null?splashPage():ChangeNotifierProvider(create: (context)=>BottomNavController(),),
    // );
  }
}