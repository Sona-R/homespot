
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Work_profile extends StatefulWidget {
  const Work_profile({super.key});

  @override
  State<Work_profile> createState() => _Work_profileState();
}

class _Work_profileState extends State<Work_profile> {




  var imageURL;
  XFile? _image;

  Future<void> pickimage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      XFile? pickedimage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedimage != null) {
        setState(() {
          _image = pickedimage;
        });
        print("Image upload succersfully");
        await uploadimage();
      }
    } catch (e) {
      print("Error picking image:$e");
    }
  }

  Future<void> uploadimage() async {
    try {
      if (_image != null) {
        Reference storrageReference =
        FirebaseStorage.instance.ref().child('profile/${_image!.path}');
        await storrageReference.putFile(File(_image!.path));
        imageURL = await storrageReference.getDownloadURL();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Uploaded succesfully",
              style: TextStyle(color: Colors.green),
            )));

        FirebaseFirestore.instance
            .collection("Mechsignup")
            .doc(ID)
            .update({"path": imageURL});
        Navigator.of(context).pop();
        print("/////////picked$imageURL");
      } else
        CircularProgressIndicator();
    } catch (e) {
      print("Error uploading image:$e");
    }
  }






  final formkey=GlobalKey<FormState>();
  // final namectrl = TextEditingController();
  var usernamectrl = TextEditingController();
  var phonectrl = TextEditingController();
  var emailctrl = TextEditingController();
  var experiencectrl = TextEditingController();
  var workingpostctrl = TextEditingController();
  var locationctrl = TextEditingController();

  var ID = '';
  void initState() {
    // TODO: implement initState
    getSavedData();
    super.initState();
  }

  void getSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    ID = prefs.getString('id')!;


    // location = prefs.getString('location')!;

    setState(() {});
  }

  updateprofile()  async{
    FirebaseFirestore.instance.collection("Mechsignup").doc(ID).update({
      "username":usernamectrl.text,
      "phone":phonectrl.text,
      "email":emailctrl.text,
      "experience":experiencectrl.text,
      "workingpost":workingpostctrl.text,
      "location":locationctrl.text,
    });
    Navigator.pop(
      context,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: ExactAssetImage("assets/images/person.jpg"),

                ),
                IconButton(onPressed: (){
                  pickimage();
                }, icon: Icon(Icons.camera_alt)),

                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 280),
                  child: Text(
                    "Enter Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
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
                        hintText:"name",
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
                  padding: const EdgeInsets.only(right: 250),
                  child: Text(
                    "Enter username",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
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
                        hintText:"username",
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
                  child: Text(
                    "Enter phone number",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: phonectrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {   // Validation Logic
                        return 'Please enter phonenumber';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                        hintText:"phone number",
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
                  child: Text(
                    "Enter Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailctrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {   // Validation Logic
                        return 'Please enter email id';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                        hintText:"email",
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
                  padding: const EdgeInsets.only(right: 170),
                  child: Text(
                    "Enter your work experience",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: experiencectrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {   // Validation Logic
                        return 'Please enter experience';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                        hintText:"work experience",
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
                  padding: const EdgeInsets.only(right: 170),
                  child: Text(
                    "Enter your working post",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: workingpostctrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {   // Validation Logic
                        return 'Please enter working post';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                        hintText:"working post",
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
                  child: Text(
                    "Enter location",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: locationctrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {   // Validation Logic
                        return 'Please enter location';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                        hintText:"location",
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
                  width: 270,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async { if(formkey.currentState!.validate()) {

                      if(formkey.currentState!.validate()) {

                        updateprofile();
                      }


                    }


                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
