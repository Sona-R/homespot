import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class User_notification extends StatefulWidget {
  const User_notification({super.key});

  @override
  State<User_notification> createState() => _User_notificationState();
}

class _User_notificationState extends State<User_notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title: Text("Notification",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
        centerTitle: true,
      ),

      body:

      FutureBuilder(
        future: FirebaseFirestore.instance.collection("Notification").get(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
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
            height: 1000,
            width: 390,
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(

                      color: Colors.white,
                      thickness: 5,

                    ),
                itemCount: notification.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.red.shade900)
                        ),
                        // height: 120,
                        // width: 150,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(notification[index]["matter"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(notification[index]["time"]),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: SizedBox(
                                      width: 280,
                                      child: Text(notification[index]["content"],style: TextStyle(fontSize: 16),)),
                                ),



                              ],
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(notification[index]["date"]),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ),
                    );
                }
            ),
          );

        },
      ),

    );


  }
}
