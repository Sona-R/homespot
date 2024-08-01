import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workers_app/workers/work_service_accept_reject.dart';

class work_home_request extends StatefulWidget {
  const work_home_request({Key? key}) : super(key: key);

  @override
  State<work_home_request> createState() => _work_home_requestState();
}

class _work_home_requestState extends State<work_home_request> {
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
        future: FirebaseFirestore.instance.collection("Mechrequest").where('mechid', isEqualTo: ID).get(),
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

          final user = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: user.length,
            itemBuilder: (context, index) {
              final userData = user[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Work_accept_reject(id: userData.id)),
                  );
                },
                child: Card(
                  color: Colors.white,
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Column(
                        children: [
                          SizedBox(height: 10),
                          userData['userprofile'].isEmpty
                              ? CircleAvatar(
                            radius: 35,
                            backgroundImage: ExactAssetImage("assets/images/person.jpg"),
                          )
                              : CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(userData["userprofile"]),
                          ),
                          Text(
                            userData['userusername'],
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userData['service'], style: TextStyle(fontSize: 15)),
                          Text(userData['date'], style: TextStyle(fontSize: 15)),
                          Text(userData['time'], style: TextStyle(fontSize: 15)),
                          Text(userData['location'], style: TextStyle(fontSize: 15)),
                        ],
                      ),
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
