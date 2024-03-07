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
    home: Trainer(),
    debugShowCheckedModeBanner: false,
  ));
}

class Trainer extends StatefulWidget {
  const Trainer({super.key});

  @override
  State<Trainer> createState() => _TrainerState();
}

class _TrainerState extends State<Trainer> {
  var name_controller = TextEditingController();
  var phone_controller = TextEditingController();
  var payment_controller = TextEditingController();
  late CollectionReference _userCollection;

  @override
  void initState() {
    _userCollection = FirebaseFirestore.instance.collection('trainer');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF473F97),
          title: Text(
            "Trainer",
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
                stream: gettrainer(),
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
                            final userphone = user['phone'];
                            final userpayment = user['payment'];

                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/images/gym_coach_trainer_fitness-512.png"),
                              ),
                              title: Text('$username',style: TextStyle(fontWeight: FontWeight.bold),),
                              subtitle: Text(
                                  'ph:$userphone\n Salary:$userpayment',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      )),
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
            padding: const EdgeInsets.all(20),
            child: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Trainer name",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: phone_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Phone number",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: payment_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Salary",
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
                    child: Text("Add Trainer "))
              ],
            )),
          );
        });
  }

  Future<void> adduser() async {
    return _userCollection.add({
      'name': name_controller.text,
      'phone': phone_controller.text,
      'payment': payment_controller.text
    }).then((value) {
      print("User added succesfully");
      name_controller.clear();
      phone_controller.clear();
      payment_controller.clear();
    }).catchError((onError) {
      print("Failed to connect$onError");
    });
  }

  Stream<QuerySnapshot> gettrainer() {
    return _userCollection.snapshots();
  }

  void edituser(var id) {
    showDialog(
        context: context,
        builder: (context) {
          final newname_cntlr = TextEditingController();
          final newsalary_cntrlr = TextEditingController();
          return AlertDialog(
            title: Text("Update Trainer"),
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
                  decoration: InputDecoration(hintText: "Payment"),
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
        .update({'name': newname, 'payment': payment}).then((value) {
      print("Trainer data updated Sucessfully");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Trainer data updated",
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
          "Deleted one Trainer",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF473F97),
      ));
    }).catchError((onError) {
      print("$onError");
    });
  }
}
