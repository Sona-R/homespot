
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workers_app/User/user_home.dart';
import 'package:workers_app/User/user_signup.dart';
class User_login extends StatefulWidget {
  const User_login({super.key});

  @override
  State<User_login> createState() => _User_loginState();
}

class _User_loginState extends State<User_login> {
  var usernamectrl = TextEditingController();
  var passwordctrl = TextEditingController();



  // final SnackBar _snackBar = SnackBar(content: Text("Successfully registered"),duration: Duration(seconds: 3),);

  final _formkey=GlobalKey<FormState>();

  String id = '';
  String username = '';
  String location ='';
  String phone ='';
  String email ='';
  // String password ='';
  String path = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,

                ),
                SizedBox(
                    height: 240,
                    width: 330,
                    child: Image.asset("assets/images/onspot.jpeg")),
                SizedBox(
                  height: 30,
                ),
                Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 250),
                  child: Text("Enter username",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller:usernamectrl ,
                    validator: (value) {
                      if (value == null || value.isEmpty) {   // Validation Logic
                        return 'Please enter username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "username",
                        filled: true,
                        fillColor: Colors.red.shade50,
                        focusedBorder: UnderlineInputBorder(

                          borderRadius: BorderRadius.circular(10),



                        ),
                        border: InputBorder.none
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 255),
                  child: Text("Enter password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                    controller: passwordctrl,
                    validator:  (value) {
                      if (value == null || value.isEmpty) {   // Validation Logic
                        return 'Please enter password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "password",
                        filled: true,
                        fillColor: Colors.red.shade50,
                        focusedBorder: UnderlineInputBorder(

                          borderRadius: BorderRadius.circular(10),



                        ),
                        border: InputBorder.none
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 210),
                  child: GestureDetector(

                      onTap: (){

                      },
                      child: Text("Forgot password ?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.red.shade800),)),
                ),
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: ElevatedButton(onPressed: (){
                    if(_formkey.currentState!.validate()) {
                      userlogin();
                      // ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      //
                      //
                    }




                  }, child: Text("LOGIN",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                  ),

                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:90 ),
                  child: Row(
                    children: [
                      Text("Do you have account?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const User_signup()),
                        );
                      }, child: Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.red.shade900),))


                    ],
                  ),
                )
              ],
            ),

          ),
        ),
      ),


    );
  }
  void userlogin() async {
    final user = await FirebaseFirestore.instance
        .collection('Usersignup')
        .where('username', isEqualTo:usernamectrl.text)
        .where('password', isEqualTo: passwordctrl.text)
        .where('status', isEqualTo: 1)
        .get();
    if (user.docs.isNotEmpty) {
      id = user.docs[0].id;
      username = user.docs[0]['username'];
      location = user.docs[0]['location'];
      phone = user.docs[0]['phone'];
      email = user.docs[0]['email'];
      // password = user.docs[0]['password'];
      // path = user.docs[0][''];

      SharedPreferences data = await SharedPreferences.getInstance();
      data.setString('id', id);
      // data.setString('paath', path);

      data.setString('username', username);
      data.setString('location', location);
      data.setString('phone', phone);
      data.setString('email', email);
      // data.setString('password', password);


      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return User_home();
      },
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(
        "Username and password error", style: TextStyle(color: Colors.red),
      )));
    }




  }
}

