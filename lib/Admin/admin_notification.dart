
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'admin_add_notification.dart';

class Admin_notification extends StatefulWidget {
  const Admin_notification({super.key});

  @override
  State<Admin_notification> createState() => _Admin_notificationState();
}

class _Admin_notificationState extends State<Admin_notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Admin_add_notification()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("Notification").get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text("Error:${snapshot.error}"),
              );
            }
            final notification = snapshot.data?.docs ?? [];

            return Container(
              height: 900,
              width: 470,
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    indent: 13,
                    endIndent: 60,
                    color: Colors.white,
                    thickness: 20,
                    height: 50,
                  ),
                  itemCount: notification.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        notification[index]["matter"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        notification[index]["content"],
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
