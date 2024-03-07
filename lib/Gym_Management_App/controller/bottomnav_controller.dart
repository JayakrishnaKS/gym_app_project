import 'package:flutter/material.dart';

import '../screens/Trainerscreen.dart';
import '../screens/equipmentscreen.dart';
import '../screens/homescreen.dart';
import '../screens/memberscreen.dart';

class BottomNavController with ChangeNotifier {
int selectedIndex = 0;

void onItemTap(index) {
  selectedIndex = index;
  notifyListeners();
}

List<Widget> myPages = [
  home_page(),Trainer(),memberlist(),Equipment()
];}