
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'admin_home.dart';

class Admin_user extends StatefulWidget {
  const Admin_user({super.key, required this.id});
  final id;

  @override
  State<Admin_user> createState() => _Admin_userState();
}

class _Admin_userState extends State<Admin_user> {
  DocumentSnapshot? user;

  getData() async {
    user = await FirebaseFirestore.instance
        .collection("Usersignup")
        .doc(widget.id)
        .get();
  }

  void accept(id) {
    setState(() {
      FirebaseFirestore.instance
          .collection("Usersignup")
          .doc(id)
          .update({'status': 1});
      print("accept");
    });
  }

  void rejects(id) {
    setState(() {
      FirebaseFirestore.instance
          .collection("Usersignup")
          .doc(id)
          .update({'status': 2});
      print("Rejected");
    });
  }

  // final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>Admin_home())
          );
        }, icon:Icon(Icons.arrow_back),iconSize: 25,),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("Error${snapshot.error}");
            }

            return Container(
              color: Colors.white24,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    user!['path']==''?
                    const CircleAvatar(
                      radius:55,
                      backgroundImage: ExactAssetImage(
                          "assets/images/person.jpg"),
                    )
                        :

                    CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                          user!["path"]),


                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      user?['username'],
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      user?['location'],
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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

                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: user?['username'],
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: user?['phone'],
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
                      padding: const EdgeInsets.only(right: 285),
                      child: Text(
                        "Enter email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: user?['email'],
                            filled: true,
                            fillColor: Colors.red.shade50,
                            focusedBorder: UnderlineInputBorder(

                              borderRadius: BorderRadius.circular(10),



                            ),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child:user!['status']==0? Row(
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
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              rejects(widget.id);
                            },
                            child: Text("Reject"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ],
                      ):user!["status"]==1? Padding(
                        padding: const EdgeInsets.only(right: 90),
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          child: Text("Accepted"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ): Padding(
                        padding: const EdgeInsets.only(right: 90),
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          child: Text("rejected"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
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
            );
          },
        ),
      ),
    );
  }
}
