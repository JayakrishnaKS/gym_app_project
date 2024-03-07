import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:gym/Gym_Management_App/Authentication/Login.dart';

import 'Firebasefunction.dart';

class signupPage extends StatefulWidget {
  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  bool showpassword = true;

  bool showconfrm_pswd = true;

  var name = TextEditingController();

  var email_cntrl = TextEditingController();

  var pass_cntrl = TextEditingController();

  var pwd;
final formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(key: formkey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  ClipPath(
                    clipper: ArcClipper(),
                    child: Container(
                      height: 220,
                      color: Color(0xFF473F97),
                      child: Center(
                          child: Column(
                        children: [
                          SizedBox(height: 37),
                          Text(
                            "Signup",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          // Text(
                          //   "Signup",
                          //   style: TextStyle(
                          //       fontSize: 20,
                          //       fontWeight: FontWeight.normal,
                          //       color: Colors.white70),
                          // ),
                        ],
                      )),
                    ),
                  ),
                  Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: TextFormField(controller: name,
                  //     decoration: InputDecoration(
                  //
                  //       filled: true,
                  //       //fillColor: Color(0xFF473F97),
                  //       hintText: "Username",
                  //       prefixIcon: Icon(Icons.person_outline_outlined),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(15),
                  //         borderSide: BorderSide.none,
                  //         // borderSide: BorderSide(color: Colors.black87)
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: email_cntrl,
                      decoration: InputDecoration(
                        filled: true,
                        //fillColor: Color(0xFF473F97),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                          // borderSide: BorderSide(color: Colors.black87)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      obscureText: showpassword,
                      obscuringCharacter: '*',
                      validator: (confirm) {
                        pwd = confirm;
                      },
                      controller: pass_cntrl,
                      decoration: InputDecoration(
                        filled: true,
                        // fillColor: Color(0xFF473F97),
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
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,

                          // borderSide: BorderSide(color: Colors.black87)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      obscuringCharacter: '*',
                      obscureText: showconfrm_pswd,
                      validator: (password) {
                        if (password != pwd) {
                          return "Password doesn't match! Check whether entered password is correct ";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        //fillColor: Color(0xFF473F97),
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            if(showconfrm_pswd==true){
                              showconfrm_pswd=false;
                            }else{
                              showconfrm_pswd=true;
                            }
                          });
                        }, icon: Icon(showconfrm_pswd==true?Icons.visibility_off:Icons.visibility)),
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,

                          // borderSide: BorderSide(color: Colors.black87)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {

                        String email = email_cntrl.text.trim();
                        String pass = pass_cntrl.text.trim();
                        FirebaseHelper()
                            .registerUser(email: email, pwd: pass)
                            .then((result) {

                          if (result == null) {


                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginPage()));
                           }else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Invalid entry"),
                              backgroundColor: Colors.redAccent,
                            ));
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFF473F97),
                        ),
                      ),
                      child: Text("Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => loginPage()));
                    },
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                          TextSpan(text: "Already  registered?  "),
                          TextSpan(
                              text: "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF568896)))
                        ])),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
