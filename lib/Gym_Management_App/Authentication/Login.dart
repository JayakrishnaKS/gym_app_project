import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:gym/Gym_Management_App/Authentication/Firebasefunction.dart';
import 'package:gym/Gym_Management_App/Authentication/Signup.dart';

import '../bottom_nav.dart';
import '../screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        storageBucket:"gym-app-f5d38.appspot.com" ,
          apiKey: "AIzaSyAa0pH-hQ0dSbc8s7vay2rQvkRi-WyUbjk",
          appId: "1:630772895305:android:575e11bc9c6e851309f998",
          messagingSenderId: "",
          projectId: "gym-app-f5d38"));
  runApp(MaterialApp(home: loginPage(),debugShowCheckedModeBanner: false,));
}

class loginPage extends StatefulWidget {
  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool showpassword=true;
  var email_cntrlr=TextEditingController();

  var pass_cntlr=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            ClipPath(
              clipper: ArcClipper(),
              child: Container(
                height: 210,
                color: Color(0xFF473F97),
                child: Center(
                    child: Column(
                  children: [
                    SizedBox(height: 27),
                    Text(
                      "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Gym Management",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.white70),
                    ),
                  ],
                )),
              ),
            ),

            // SizedBox(
            //   height: 20,#d6e5ea
            // ),
            Text(
              "Login",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(controller: email_cntrlr,
                decoration: InputDecoration(
                   filled: true,
                 // fillColor: Color(0xFF473F97),
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(obscureText: showpassword,
                obscuringCharacter: '*',
                controller: pass_cntlr,
                decoration: InputDecoration(
                  filled: true,
                  //fillColor: Color(0xFF473F97),
                  hintText: "Password",
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      if(showpassword==true){
                        showpassword=false;
                      }else{
                        showpassword=true;
                      }
                    });
                  },icon:  Icon(showpassword==true?Icons.visibility_off:Icons.visibility),),
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),

                    // borderSide: BorderSide(color: Colors.black87)
                  ),
                ),
              ),
            ),
            // ListTile(
            //     trailing: TextButton(
            //       onPressed: () {},
            //       child: Text("Forget password?",
            //           style: TextStyle(color: Colors.black)),
            //     )),
            SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  String email=email_cntrlr.text.trim();
                  String password=pass_cntlr.text.trim();
                  FirebaseHelper().loginuser(email:email,pwd:password).then((result) {
                    if (result == null) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNav()));

                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.blue, content: Text(result)));
                    }
                  });

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xFF568896),
                  ),
                ),
                child: Text("Login",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>signupPage()));},
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                    TextSpan(text: "Dont have an account?  "),
                    TextSpan(
                        text: "signup",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF568896)))
                  ])),
            )
          ]),
        ),
      ),
    );
  }
}
//
// void main() {
//   runApp(MaterialApp(
//     home: login_stateful(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
//
// class login_stateful extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return login_statefulstate();
//   }
// }
//
// class login_statefulstate extends State<login_stateful> {
//   final formkey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login page"),
//       ),
//       body: Padding(
//         padding:
//             const EdgeInsets.only(left: 28.0, right: 28.0, top: 20, bottom: 20),
//         child: Form(
//           key: formkey,
//           child: Column(
//             children: [
//               Image(
//                 image: AssetImage("assets/images/gym.jpg"),
//                 height: 200,
//                 width: 200,
//               ),
//               TextFormField(
//                 validator: (Username) {
//                   if (Username!.isEmpty || !Username.contains('@')) {
//                     return 'username is invalid!';
//                   } else {
//                     return null;
//                   }
//                 },
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                     hintText: "username"),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               TextFormField(
//                 validator: (password) {
//                   if (password!.isEmpty || password!.length < 6) {
//                     return 'Password is invalid';
//                   } else {
//                     return null;
//                   }
//                 },
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                     hintText: "password"),
//               ),
//               MaterialButton(
//                   color: Colors.white10,
//                   shape: StadiumBorder(),
//                   minWidth: 170,
//                   height: 50,
//                   child: Text(
//                     "Login",
//                     style: TextStyle(color: Colors.redAccent),
//                   ),
//                   onPressed: () {
//                     final valid = formkey.currentState?.validate();
//                     if (valid == true) {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => MusicApp()));
//                     }
//                   }),
//               TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => signup_stateful()));
//                   },
//                   child: Text("don't have an account? SIGNUP here"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
