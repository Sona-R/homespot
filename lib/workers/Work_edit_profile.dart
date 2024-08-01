


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workers_app/workers/work_home.dart';

import 'Work_profile.dart';
class Work_edit_profile extends StatefulWidget {
  const Work_edit_profile({super.key});

  @override
  State<Work_edit_profile> createState() => _Work_edit_profileState();





}

class _Work_edit_profileState extends State<Work_edit_profile> {





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
  DocumentSnapshot? mech;
  getupdateddata() async{
    mech =
    await FirebaseFirestore.instance.collection("Mechsignup").doc(ID).get();
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
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 320),
                    child: IconButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Work_profile()),
                      );
                    },
                        icon: Icon(
                          Icons.edit_calendar_outlined, color: Colors.black,)),
                  ),mech!['path']==''?

                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: ExactAssetImage(
                        "assets/images/person.jpg"),
                  )
                      :

                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        mech!["path"]),


                   ),

                  SizedBox(
                    height: 30,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      readOnly: true,


                      decoration: InputDecoration(
                          hintText: mech!['username'],
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      readOnly: true,


                      decoration: InputDecoration(
                          hintText: mech!['username'],
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      readOnly: true,


                      decoration: InputDecoration(
                          hintText: mech!['phone'],
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      readOnly: true,


                      decoration: InputDecoration(
                          hintText: mech!['email'],
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      readOnly: true,


                      decoration: InputDecoration(
                          hintText: mech!['experience'],
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      readOnly: true,


                      decoration: InputDecoration(
                          hintText: mech!['workingpost'],
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      readOnly: true,


                      decoration: InputDecoration(
                          hintText: mech!['location'],
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
                            borderRadius: BorderRadius.circular(8)
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Work_home()),
                        );
                      },
                      child: Text("Done",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight
                            .bold,),
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
