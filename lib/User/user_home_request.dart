import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workers_app/User/user_rating.dart';

class User_home_request extends StatefulWidget {
  const User_home_request({Key? key}) : super(key: key);

  @override
  State<User_home_request> createState() => _User_home_requestState();
}

class _User_home_requestState extends State<User_home_request> {
  late QuerySnapshot? userSnapshot;

  @override
  void initState() {
    getSavedData();
    super.initState();
  }

  var ID = '';
  Future<void> getSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ID = prefs.getString('id')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Mechrequest")
            .where('userid', isEqualTo: ID)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          final mech = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: mech.length,
            itemBuilder: (context, index) {
              final mechData = mech[index];
              return InkWell(
                onTap: () {},
                child: Card(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(mechData['username'],
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Text(mechData['date'],
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          Text(mechData['time'],
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          Text(mechData['service'],
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Spacer(),
                      mechData['status'] == 1
                          ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => User_rating(

                              ),
                            ),
                          );
                        },
                            child: Container(
                                                    height: 30,
                                                    width: 130,
                                                    decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green),
                                                    child: Center(
                            child: Text(
                              "Approved",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                                                    ),
                                                  ),
                          )
                          : mechData['status'] == 2
                          ? Container(
                        height: 30,
                        width: 130,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        child: Center(
                          child: Text(
                            "Rejected",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                          : Text(""),
                      Spacer(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
