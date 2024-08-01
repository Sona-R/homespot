
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workers_app/User/user_login.dart';
class User_signup extends StatefulWidget {
  const User_signup({super.key});

  @override
  State<User_signup> createState() => _User_signupState();
}

class _User_signupState extends State<User_signup> {


  List<String> locations = [
    'Thiruvananthapuram',
    'Kollam',
    'Alappuzha',
    'Pathanamthitta',
    'Kottayam',
    'Idukki',
    'Ernakulam',
    'Thrissur',
    'Palakkad',
    'Malappuram',
    'Kozhikode',
    'Wayanad',
    'Kannur',
    'Kasaragod'
  ];
  String? selectedLocation;



  var usernamectrl =TextEditingController();
  var phonectrl =TextEditingController();
  var emailctrl =TextEditingController();
  var passwordctrl =TextEditingController();
  // var locationctrl =TextEditingController();
  Future<dynamic> usersignup() async {
    await FirebaseFirestore.instance.collection('Usersignup').add({
      "username": usernamectrl.text,
      // "location": locationctrl.text,
      "phone": phonectrl.text,
      "email": emailctrl.text,
      "password": passwordctrl.text,
      'location':selectedLocation,
      "path":'',
      "status": 0
    }).then((value) {
      print("success");
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const User_login())
      );
    });

  }
  final SnackBar _snackBar = SnackBar(content: Text("Successfully registered"),duration: Duration(seconds: 3),);


  final formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,

                ),
                SizedBox(
                    height: 180,
                    width: 270,
                    child: Image.asset("assets/images/onspot.jpeg")),
                SizedBox(
                  height: 30,
                ),
                Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 240),
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
                  padding: const EdgeInsets.only(right: 220),
                  child: Text("Enter your location",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 180),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.red.shade50,
                    iconEnabledColor: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    style: TextStyle(color: Colors.black, fontSize: 17),
                    hint: Text("select your location",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    value: selectedLocation, // Current selected location
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLocation = newValue!;
                      });
                    },
                    items: locations.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 220),
                  child: Text("Enter phone number",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: phonectrl,

                    validator:  (value) {
                      if (value == null || value.isEmpty) {   // Validation Logic
                        return 'Please Phone number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "phone number",
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
                  padding: const EdgeInsets.only(right: 280),
                  child: Text("Enter Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailctrl,

                    // validator:  (value) {
                    //   if (value == null || value.isEmpty) {   // Validation Logic
                    //     return 'Please enter email';
                    //   }
                    //   return null;
                    // },
                    decoration: InputDecoration(
                        hintText: "email",
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
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: (){
                      if(formkey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        usersignup();


                      }



                    }, child: Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                  ),
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
                  height: 30,
                ),

              ],
            ),

          ),
        ),
      ),


    );
  }
}
