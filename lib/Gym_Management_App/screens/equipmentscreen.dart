import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          storageBucket: "gym-app-f5d38.appspot.com",
          apiKey: "AIzaSyAa0pH-hQ0dSbc8s7vay2rQvkRi-WyUbjk",
          appId: "1:630772895305:android:575e11bc9c6e851309f998",
          messagingSenderId: "",
          projectId: "gym-app-f5d38"));
  runApp(MaterialApp(
    home: Equipment(),
    debugShowCheckedModeBanner: false,
  ));
}

class Equipment extends StatefulWidget {
  const Equipment({super.key});

  @override
  State<Equipment> createState() => _EquipmentState();
}

class _EquipmentState extends State<Equipment> {
  var name_controller = TextEditingController();
 // DateTime selectedDate = DateTime.now();
  var Categorycontroller = TextEditingController();
  var Calendarcontroller = TextEditingController();
  late CollectionReference _userCollection;

  @override
  void initState() {
    _userCollection = FirebaseFirestore.instance.collection('Equipment');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF473F97),
          title: Text(
            "Equipment",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            add(context);
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: equipment(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error${snapshot.error}");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  final users = snapshot.data!.docs;
                  return Expanded(
                      child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            final userId = user.id;
                            final username = user['name'];
                            final userphone = user['category'];
                            final userpayment = user['Date'];

                            return ListTile(
                              leading: CircleAvatar(
                                  child: Icon(Icons.fitness_center,color: Colors.black,)),
                              title: Text('Name:$username',style: TextStyle(fontWeight: FontWeight.bold),),
                              subtitle:
                                  Text('Category:$userphone\n Service date:$userpayment',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontStyle: FontStyle.italic),),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        edituser(userId);
                                      },
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        deleteuser(userId);
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            );
                          }));
                }),
          ],
        ),
      ),
    );
  }

  Future<void> add(BuildContext context) async {
    showModalBottomSheet(
        elevation: 1,
        shape: OutlineInputBorder(
          borderSide: BorderSide(width: 0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        context: (context),
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Equipment Category",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller:Calendarcontroller,

                    decoration: InputDecoration(
                        labelText: "DD-MM-YY",
                        suffixIcon: Icon(Icons.calendar_month))),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: Categorycontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Equipment Name",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      adduser();
                      Navigator.pop(context);
                    },
                    child: Text("Add Equipments "))
              ],
            )),
          );
        });
  }

  Future<void> adduser() async {
    return _userCollection.add({
      'name': name_controller.text,
      'category': Categorycontroller.text,
      'Date': Calendarcontroller.text
    }).then((value) {
      print("User added succesfully");
      name_controller.clear();
      Categorycontroller.clear();
      Calendarcontroller.clear();
    }).catchError((onError) {
      print("Failed to connect$onError");
    });
  }

  Stream<QuerySnapshot> equipment() {
    return _userCollection.snapshots();
  }

  void edituser(var id) {
    showDialog(
        context: context,
        builder: (context) {
          final newname_cntlr = TextEditingController();
          final newsalary_cntrlr = TextEditingController();
          return AlertDialog(
            title: Text("Update Equipment"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: newname_cntlr,
                  decoration: InputDecoration(hintText: "Enter Name"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: newsalary_cntrlr,
                  decoration: InputDecoration(hintText: "DD-MM-YY"),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    updateuser(id, newname_cntlr.text, newsalary_cntrlr.text)
                        .then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Update"))
            ],
          );
        });
  }

  Future<void> updateuser(id, String newname, String payment) {
    return _userCollection
        .doc(id)
        .update({'name': newname, 'Date': payment}).then((value) {
      print(" data updated Sucessfully");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Equipment  updated",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF473F97),
      ));
    }).catchError((onError) {
      print("$onError");
    });
  }

  Future<void> deleteuser(var id) {
    return _userCollection.doc(id).delete().then((value) {
      print("Trainer deleted Succesfully");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Deleted Equipment",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF473F97),
      ));
    }).catchError((onError) {
      print("$onError");
    });
  }


}
