
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workers_app/workers/work_home.dart';
import 'package:workers_app/workers/work_signup.dart';
class Work_Login extends StatefulWidget {
  const Work_Login({super.key});

  @override
  State<Work_Login> createState() => _Work_LoginState();
}

class _Work_LoginState extends State<Work_Login> {
  var usernamectrl = TextEditingController();
  var passwordctrl = TextEditingController();

  final _formkey=GlobalKey<FormState>();



  String id = '';
  String username = '';
  // String location ='';
  String phone ='';
  String email ='';
  String experience ='';
  String workingpost ='';

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
                    controller: usernamectrl,
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
                    // decoration: InputDecoration(
                    //     hintText: " username",
                    //
                    //
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    //     )
                    // ),
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
                    obscureText: true,
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
                    // decoration: InputDecoration(
                    //   hintText: " Password",
                    //
                    //
                    //   border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    //   ),
                    //
                    // ),
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

                      mechlogin();

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>const Work_signup ()),
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


  void mechlogin() async {
    final mech = await FirebaseFirestore.instance
        .collection('Mechsignup')
        .where('username', isEqualTo:usernamectrl.text)
         .where('password', isEqualTo: passwordctrl.text)
        .where('status', isEqualTo: 1)
        .get();
    if (mech.docs.isNotEmpty) {
      id = mech.docs[0].id;
      username = mech.docs[0]['username'];
      // location = mech.docs[0]['location'];
      phone = mech.docs[0]['phone'];
      email = mech.docs[0]['email'];
      experience = mech.docs[0]['experience'];
      workingpost = mech.docs[0]['workingpost'];
      // password = user.docs[0]['password'];
      // path = user.docs[0][''];

      SharedPreferences data = await SharedPreferences.getInstance();
      data.setString('id', id);
      // data.setString('paath', path);

      data.setString('username', username);
      // data.setString('location', location);
      data.setString('phone', phone);

      data.setString('email', email);
      data.setString('experience', experience);
      data.setString('workingpost', workingpost);
      // data.setString('password', password);


      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Work_home();
      },
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(
        "Username and password error", style: TextStyle(color: Colors.red),
      )));
    }




  }
}
