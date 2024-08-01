import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';  // Add this import for url_launcher

import 'admin_home.dart';

class Admin_worker extends StatefulWidget {
  const Admin_worker({super.key, required this.id});
  final id;

  @override
  State<Admin_worker> createState() => _Admin_workerState();
}

class _Admin_workerState extends State<Admin_worker> {
  DocumentSnapshot? mech;

  getData() async {
    mech = await FirebaseFirestore.instance
        .collection("Mechsignup")
        .doc(widget.id)
        .get();
    setState(() {});  // Add this line to update the UI after getting data
  }

  void accept(id) {
    setState(() {
      FirebaseFirestore.instance
          .collection("Mechsignup")
          .doc(id)
          .update({'status': 1});
      print("accept");
    });
  }

  void rejects(id) {
    setState(() {
      FirebaseFirestore.instance
          .collection("Mechsignup")
          .doc(id)
          .update({'status': 2});
      print("reject");
    });
  }

  @override
  void initState() {
    super.initState();
    getData();  // Ensure getData is called when the widget is first created
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Admin_home()));
          },
          icon: Icon(Icons.arrow_back),
          iconSize: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: mech == null
            ? Center(child: CircularProgressIndicator())
            : Container(
          color: Colors.white54,
          child: Center(
            child: Column(
              children: [
                mech!['path'] == ''
                    ? const CircleAvatar(
                  radius: 55,
                  backgroundImage:
                  ExactAssetImage("assets/images/person.jpg"),
                )
                    : CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(mech!["path"]),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  mech?['username'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'location',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 255),
                  child: Text(
                    "Enter username",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: mech?['username'],
                        filled: true,
                        fillColor: Colors.red.shade50,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 220),
                  child: Text(
                    "Enter phone number",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: mech?['phone'],
                        filled: true,
                        fillColor: Colors.red.shade50,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 285),
                  child: Text(
                    "Enter Email",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: mech?['email'],
                        filled: true,
                        fillColor: Colors.red.shade50,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 210),
                  child: Text(
                    "Enter work experience",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: mech?['experience'],
                        filled: true,
                        fillColor: Colors.red.shade50,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 170),
                  child: Text(
                    "Enter your working post",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: mech?['workingpost'],
                        filled: true,
                        fillColor: Colors.red.shade50,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 230),
                  child: Text(
                    "Enter your location",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: mech?['location'],
                        filled: true,
                        fillColor: Colors.red.shade50,
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: TextButton(
                    onPressed: () {
                      _launchURL(mech!['resumeUrl']);
                    },
                    child: Text("View uploaded resume"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: TextButton(
                    onPressed: () {
                      _launchURL(mech!['idProofUrl']);
                    },
                    child: Text("View uploaded ID proof"),
                  ),
                ),
                SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: mech!['status'] == 0
                      ? Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          accept(widget.id);
                        },
                        child: Text("Accept"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(5)),
                        ),
                      ),
                      SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () {
                          rejects(widget.id);
                        },
                        child: Text("Reject"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(5)),
                        ),
                      ),
                    ],
                  )
                      : mech!["status"] == 1
                      ? Padding(
                    padding: const EdgeInsets.only(right: 90),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Accepted"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(5)),
                      ),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.only(right: 90),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Rejected"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(5)),
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
