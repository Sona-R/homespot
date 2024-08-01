

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:number_paginator/number_paginator.dart';

import 'admin_user.dart';



class Admin_home_user extends StatefulWidget {
  const Admin_home_user({Key? key}) : super(key: key);

  @override
  State<Admin_home_user> createState() => _Admin_home_userState();
}

class _Admin_home_userState extends State<Admin_home_user> {
  int currentPage = 0;
  int itemsPerPage = 2;
  late QuerySnapshot? userSnapshot;

  Future<void> getData() async {
    userSnapshot = await FirebaseFirestore.instance.collection("Usersignup").get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
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

          final user = userSnapshot?.docs ?? [];
          final totalItems = user.length;
          final totalPages = (totalItems / itemsPerPage).ceil();

          return Column(
            children: [
              NumberPaginator(
                numberPages: totalPages,
                initialPage: currentPage,
                onPageChange: (int newPage) {
                  setState(() {
                    currentPage = newPage;
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: (currentPage == totalPages - 1)
                      ? totalItems - (currentPage * itemsPerPage)
                      : itemsPerPage,
                  itemBuilder: (context, index) {
                    final dataIndex = (currentPage * itemsPerPage) + index;
                    if (dataIndex >= totalItems) {
                      return SizedBox(); // Return an empty SizedBox if no more data
                    }

                    final userData = user[dataIndex];
                    return InkWell(
                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Admin_user(id: userData.id),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(height: 20,),
                            userData['path'].isEmpty?
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: ExactAssetImage(
                                  "assets/images/person.jpg"),
                            )
                                :

                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  userData["path"]),


                            ),
                            SizedBox(width: 30,),



                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(userData['username'], style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),),
                                Text(
                                    userData["location"], style: TextStyle(fontSize: 15,)),
                                Text(userData["phone"],
                                    style: TextStyle(fontSize: 15,)),
                                Text(userData["email"], style: TextStyle(fontSize: 15,)),
                                SizedBox(height: 15,),
                              ],
                            ),
                            Spacer(),

                            userData['status']==0? Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange),
                              child: Center(
                                child: Text(
                                  "pending",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,fontWeight: FontWeight.bold

                                  ),

                                ),
                              ),

                            ):userData['status']==1? Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green),
                              child: Center(
                                child: Text(
                                  "Accepted",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,fontWeight: FontWeight.bold

                                  ),

                                ),
                              ),

                            ):  Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red),
                              child: Center(
                                child: Text(
                                  "Rejected",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,fontWeight: FontWeight.bold

                                  ),

                                ),
                              ),
                            ),



                          ],
                        ),
                      ),


                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}