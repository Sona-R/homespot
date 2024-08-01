import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workers_app/Admin/Admin_rejectreason.dart';
import 'package:workers_app/Admin/admin_worker.dart';

class Admin_home_worker extends StatefulWidget {
  const Admin_home_worker({Key? key}) : super(key: key);

  @override
  State<Admin_home_worker> createState() => _Admin_home_workerState();
}

class _Admin_home_workerState extends State<Admin_home_worker> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("Mechsignup").get(),
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
              final mechData = mech[index].data() as Map<String, dynamic>;
              final docId = mech[index].id;  // Correctly get the document ID
              final path = mechData['path'] ?? '';  // Use default value if 'path' is missing
              final username = mechData['username'] ?? 'Unknown User';  // Default value
              final phone = mechData['phone'] ?? 'No phone';  // Default value
              final experience = mechData['experience'] ?? 'No experience';  // Default value
              final status = mechData['status'] ?? -1;  // Default value if 'status' is missing

              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Admin_worker(id: docId),  // Pass the document ID correctly
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        SizedBox(height: 20),
                        path.isEmpty
                            ? CircleAvatar(
                          radius: 35,
                          backgroundImage: ExactAssetImage("assets/images/person.jpg"),
                        )
                            : CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(path),
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 25),
                            Text(
                              username,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              phone,
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              experience,
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 25),
                          ],
                        ),
                        Spacer(),
                        status == 0
                            ? Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.orange,
                          ),
                          child: Center(
                            child: Text(
                              "Pending",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                            : status == 1
                            ? Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Text(
                              "Accepted",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                            : Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: TextButton(onPressed: (){
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Admin_rejectreason()),
                              );
                            }
                              ,
                               child: Text(
                                "Rejected",
                                style: TextStyle(
                                   color: Colors.white,
                                  fontSize: 12,
                                   fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
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
