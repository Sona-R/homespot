

import 'package:flutter/material.dart';

import 'admin_home.dart';
class Admin_login extends StatefulWidget {
  const Admin_login({super.key});

  @override
  State<Admin_login> createState() => _Admin_loginState();
}

class _Admin_loginState extends State<Admin_login> {
  // final SnackBar _snackBar = SnackBar(content: Text("Successfully registered"),duration: Duration(seconds: 3),);

  var usernamectrl =TextEditingController();
  var passwordctrl =TextEditingController();
  final _formkey=GlobalKey<FormState>();
  login(){
    print("object");
    if (usernamectrl.text =='admin@gmail.com' && passwordctrl.text =='123'){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Admin_home()),
      );
    }
  }

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

                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: ElevatedButton(onPressed: (){
                    // ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                    login();
                    if(_formkey.currentState!.validate()) { }



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
              ],
            ),

          ),
        ),
      ),

    );
  }
}
