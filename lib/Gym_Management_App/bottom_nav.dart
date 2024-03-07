import 'package:flutter/material.dart';

// import 'package:gym/Gym_Management_App/screens/Trainerscreen.dart';
// import 'package:gym/Gym_Management_App/screens/equipmentscreen.dart';
// import 'package:gym/Gym_Management_App/screens/homescreen.dart';
// import 'package:gym/Gym_Management_App/screens/memberscreen.dart';
import 'package:provider/provider.dart';

import 'controller/bottomnav_controller.dart';



void main(){
  runApp(MaterialApp(
    home: BottomNav(),
    debugShowCheckedModeBanner: false,
  ));
}
class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  //int index = 0;
  //var screen =[home_page(),Trainer(),memberlist(),Equipment()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<BottomNavController>(context)
          .myPages[Provider.of<BottomNavController>(context).selectedIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFF473F97)),
          child: BottomNavigationBar(
              currentIndex:
              Provider.of<BottomNavController>(context).selectedIndex,
              onTap: Provider.of<BottomNavController>(context, listen: false)
                  .onItemTap,
              elevation: 0,
              backgroundColor: const Color(0xFF473F97),
              selectedIconTheme: const IconThemeData(
                color: Colors.white,
                size: 25,
              ),
              unselectedIconTheme: const IconThemeData(
                size: 25,
              ),
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.white,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(backgroundColor: Color(0xFF473F97),
                    icon: Icon(Icons.home),
                    label: "Home"),
                BottomNavigationBarItem(backgroundColor: Color(0xFF473F97),
                    icon: Icon(Icons.person),
                    label: "Trainer"),
                BottomNavigationBarItem(backgroundColor: Color(0xFF473F97),
                    icon: Icon(Icons.people),
                    label: "Members"),
                BottomNavigationBarItem(backgroundColor: Color(0xFF473F97),
                    icon: Icon(Icons.fitness_center),
                    label: "Equipment")
              ]),
        ),
      ),
    );
    //   Scaffold(
    //
    //   bottomNavigationBar: BottomNavigationBar(
    //
    //     items: const [
    //       BottomNavigationBarItem(icon: Icon(Icons .home),label: 'Home',backgroundColor: Color(0xFF473F97),activeIcon: Icon(Icons.home,color: Colors.black54,)),
    //       BottomNavigationBarItem(icon: Icon(Icons .person),label: "Trainer",backgroundColor: Color(0xFF473F97),activeIcon: Icon(Icons.person,color: Colors.black54,)),
    //       BottomNavigationBarItem(icon: Icon(Icons.people,),label: "Member",backgroundColor: Color(0xFF473F97),activeIcon: Icon(Icons.people,color: Colors.black54,)),
    //       BottomNavigationBarItem(icon: Icon(Icons.fitness_center,),label: "Equipment",backgroundColor: Color(0xFF473F97),activeIcon: Icon(Icons.fitness_center,color: Colors.black54,)),
    //
    //
    //     ],
    //     onTap: (tapindex) {
    //       setState(() {
    //         index = tapindex;
    //       });
    //     },
    //     currentIndex:index ,
    //     selectedItemColor: Colors.blue,
    //      ),
    //   body: screen[index],
    // );
  }
}