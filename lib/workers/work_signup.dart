import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:workers_app/workers/work_login.dart';

class Work_signup extends StatefulWidget {
  const Work_signup({super.key});

  @override
  State<Work_signup> createState() => _Work_signupState();
}

class _Work_signupState extends State<Work_signup> {
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

  var usernamectrl = TextEditingController();
  var phonectrl = TextEditingController();
  var emailctrl = TextEditingController();
  var experencectrl = TextEditingController();
  var workingpostctrl = TextEditingController();
  var passwordctrl = TextEditingController();

  File? resumeFile;
  File? idProofFile;

  final picker = ImagePicker();

  Future pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        resumeFile = File(result.files.single.path!);
      });
    }
  }

  Future pickIDProof() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        idProofFile = File(pickedFile.path);
      }
    });
  }

  Future<dynamic> mechsignup() async {
    String? resumeUrl;
    String? idProofUrl;

    if (resumeFile != null) {
      resumeUrl = await uploadFile(resumeFile!, 'resumes/${usernamectrl.text}.pdf');
    }

    if (idProofFile != null) {
      idProofUrl = await uploadFile(idProofFile!, 'id_proofs/${usernamectrl.text}.jpg');
    }

    await FirebaseFirestore.instance.collection('Mechsignup').add({
      "username": usernamectrl.text,
      "phone": phonectrl.text,
      "email": emailctrl.text,
      'location': selectedLocation,
      "experience": experencectrl.text,
      "workingpost": workingpostctrl.text,
      "password": passwordctrl.text,
      "resumeUrl": resumeUrl,
      "idProofUrl": idProofUrl,
      "status": 0,
      "path":''
    }).then((value) {
      print("success");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Work_Login()));
    });
  }

  Future<String> uploadFile(File file, String path) async {
    final storageRef = FirebaseStorage.instance.ref().child(path);
    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  final SnackBar _snackBar = SnackBar(
    content: Text("Successfully registered"),
    duration: Duration(seconds: 3),
  );

  final formkey = GlobalKey<FormState>();

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
                SizedBox(height: 40),
                SizedBox(
                    height: 180,
                    width: 270,
                    child: Image.asset("assets/images/onspot.jpeg")),
                SizedBox(height: 30),
                Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(right: 240),
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
                      if (value == null || value.isEmpty) {
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
                      border: InputBorder.none,
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
                      if (value == null || value.isEmpty) {
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
                      border: InputBorder.none,
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
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "email",
                      filled: true,
                      fillColor: Colors.red.shade50,
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 270),
                  child: Text(
                    "Enter location",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 180),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.red.shade50,
                    iconEnabledColor: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    style: TextStyle(color: Colors.black, fontSize: 17),
                    hint: Text(
                      "select your location",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    value: selectedLocation,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLocation = newValue!;
                      });
                    },
                    items: locations
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
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
                    controller: experencectrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Your work experience';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "work experience",
                      filled: true,
                      fillColor: Colors.red.shade50,
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: InputBorder.none,
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
                      if (value == null || value.isEmpty) {
                        return 'Please enter your working post';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "workingpost",
                      filled: true,
                      fillColor: Colors.red.shade50,
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 255),
                  child: Text(
                    "Enter password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordctrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 255),
                  child: Text(
                    "Upload Resume",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 255),
                  child: IconButton(
                    onPressed: pickResume,
                    icon: Icon(Icons.filter_b_and_w),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 255),
                  child: Text(
                    "Upload ID proof",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 255),
                  child: IconButton(
                    onPressed: pickIDProof,
                    icon: Icon(Icons.camera_alt),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const Work_Login()));
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                         mechsignup();
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                         fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
