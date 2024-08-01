import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workers_app/User/user_worker_details.dart';

class User_home_mechanic extends StatefulWidget {
  const User_home_mechanic({Key? key, required this.selectedLocation})
      : super(key: key);

  final String? selectedLocation;

  @override
  State<User_home_mechanic> createState() => _User_home_mechanicState();
}

class _User_home_mechanicState extends State<User_home_mechanic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Mechsignup')
            .where('status', isEqualTo: 1)
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
          List<DocumentSnapshot> filteredMechanics = [];
          if (widget.selectedLocation != null) {
            // Filter mechanics by selected location
            filteredMechanics = mech
                .where((doc) => doc['location'] == widget.selectedLocation)
                .toList();
          } else {
            // Show all mechanics if no location selected
            filteredMechanics = [...mech];
          }

          return ListView.builder(
            itemCount: filteredMechanics.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => User_worker_details(
                        id: filteredMechanics[index].id,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    color: Colors.white,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Column(
                          children: [
                            SizedBox(height: 10),
                            filteredMechanics[index]['path'] == ''
                                ? CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage("assets/images/person.jpg"),
                            )
                                : CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(filteredMechanics[index]['path']),
                            ),
                            Text(
                              filteredMechanics[index]['username'],
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filteredMechanics[index]['experience'],
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              filteredMechanics[index]['location'],
                              style: TextStyle(fontSize: 16),
                            ),
                            Container(
                              width: 70,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  "Available",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
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
