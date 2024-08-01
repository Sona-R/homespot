import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Work_home_accepted extends StatefulWidget {
  const Work_home_accepted({Key? key}) : super(key: key);

  @override
  State<Work_home_accepted> createState() => _Work_home_acceptedState();
}

class _Work_home_acceptedState extends State<Work_home_accepted> {
  late QuerySnapshot? userSnapshot;

  @override
  void initState() {
    getSavedData();
    super.initState();
  }

  var ID = '';

  void getSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    ID = prefs.getString('id')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("Mechrequest").where('status', isEqualTo: 1).get(),
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
                  // Handle onTap action if necessary
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Card(
                    color: Colors.white,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Column(
                          children: [
                            SizedBox(height: 20),
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
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(width: 40),
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
                        userData['status'] == 0
                            ? Container(
                          height: 30,
                          width: 130,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Text(
                              "accepted",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                            : Text(""),
                      ],
                    ),
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
