import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/Gym_Management_App/Authentication/Signup.dart';

import '../Authentication/Firebasefunction.dart';
import '../widget/statsgrid.dart';

class home_page extends StatefulWidget {
  @override
  State<home_page> createState() => _homepageState();
}

class _homepageState extends State<home_page> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var listss = [
    "assets/images/personal-trainer-1-compressor.jpg",
    "assets/images/members.jpg",
    "assets/images/machiness.jpg",
    "assets/images/dumbells.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF473F97),
          centerTitle: true,
          title: Text(
            "Home page",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatsGrid(
                    'Members', 'assets/images/membericon.png'),
                StatsGrid('Trainers',
                    'assets/images/gym_coach_trainer_fitness-512.png'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatsGrid('Equipments', 'assets/images/equipmenticon.png'),
              ],
            ),
          ],
        )),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFF473F97)),
                  // otherAccountsPictures: [
                  //   CircleAvatar(backgroundImage: ,)
                  // ],
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/drawer.jpg"),
                  ),
                  accountName: Text("Welcome"),
                  accountEmail: Text("${user?.email}")),
              ListTile(
                leading: IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    "*This App Helps to store the details of  the gym you own \n"
                                        "*Which includes member,equipment and even Trainer"
                                        "\n*It Works by Listing the details like a Notepad \n"
                                        "*By clicking the Floatingaction button the action is performed\n"
                                        "*Details such as contact number and salary of trainer can be list")
                              ],
                            ),
                          );
                        }),
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.black,
                    )),
                title: Text("About", style: TextStyle(color: Colors.black)),
              ),
              ListTile(
                leading: IconButton(
                    onPressed: () {
                      FirebaseHelper().logout().then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => signupPage())));
                    },
                    icon: Icon(Icons.logout)),
                title: Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
