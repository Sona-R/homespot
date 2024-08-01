

import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workers_app/User/user_home.dart';
class User_profile extends StatefulWidget {
  const User_profile({super.key});

  @override
  State<User_profile> createState() => _User_profileState();
}

class _User_profileState extends State<User_profile> {



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
            .collection("Usersignup")
            .doc(ID)
            .update({"path": imageURL});
        // Navigator.of(context).pop();
        print("/////////picked$imageURL");
      } else
        CircularProgressIndicator();
    } catch (e) {
      print("Error uploading image:$e");
    }
  }





  @override
  void initState() {
    // TODO: implement initState
    getSavedData();
    super.initState();
  }
  var ID = '';

  Future<void>getSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();



    setState(() {
      ID = prefs.getString('id')!;
      print("get from sp");
    });

  }
  DocumentSnapshot? user;
  getupdateddata() async{
    user =
    await FirebaseFirestore.instance.collection("Usersignup").doc(ID).get();
    print("get from fb");

  }







  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      future:  getupdateddata(),
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }


        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,

                  ),
                  user!['path']==''?
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: ExactAssetImage(
                        "assets/images/person.jpg"),
                  )
                      :

                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        user!["path"]),


                  ),
                  IconButton(onPressed: (){
                    pickimage();

                  }, icon: Icon(Icons.camera_alt)),

                  Text(user!['username'], style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 19),),

                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 325),
                    child: Text(" Name", style: TextStyle(fontWeight: FontWeight
                        .bold, fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      decoration: InputDecoration(
                          hintText: user!['username'],
                          hintStyle: TextStyle(color: Colors.black),


                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(8.0)),
                          )
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 255),
                    child: Text(
                      " phone number", style: TextStyle(fontWeight: FontWeight
                        .bold, fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      decoration: InputDecoration(
                        hintText: user!['phone'],
                        hintStyle: TextStyle(color: Colors.black),


                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 325),
                    child: Text(
                      " Email", style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      decoration: InputDecoration(
                        hintText: user!['email'],
                        hintStyle: TextStyle(color: Colors.black),


                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),

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
                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => User_home()),
                        );



                      }, child: Text("Done", style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold,),

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

        );
      },
    );
  }
}
