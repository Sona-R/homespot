import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Work_rating extends StatefulWidget {
  const Work_rating({super.key});

  @override
  State<Work_rating> createState() => _Work_ratingState();
}

class _Work_ratingState extends State<Work_rating> {
  double rating = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getSavedData();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title: Text(
          "Rating",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Mechrequest")
            .where('mechid', isEqualTo: ID)
            .where('final', isEqualTo: 3)
            .get(),
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
          final user = snapshot.data?.docs ?? [];

          return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                thickness: 2,
                color: Colors.green.shade50,
              ),
              itemCount: user.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          user[index]['userprofile'] == ''
                              ? const CircleAvatar(
                            radius: 35,
                            backgroundImage: ExactAssetImage(
                                "assets/images/person.jpg"),
                          )
                              : CircleAvatar(
                             radius: 35,
                            backgroundImage: NetworkImage(
                                user[index]["userprofile"]),
                          ),
                          Text(user![index]["userusername"],
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user[index]["service"],
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(user[index]["date"],
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Text(user[index]["time"],
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Text(user[index]["location"],
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ],
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Column(
                        children: [
                          Text("Rating"),
                          SizedBox(
                            child: RatingBar.builder(
                              itemSize: 20,
                              initialRating: user[index]['rating'].toDouble(),
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                              EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  this.rating = rating;
                                });
                              },
                            ),
                          ),
                          Text(user[index]['rating'].toString())
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
