
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:workers_app/User/user_home.dart';
class User_rating extends StatefulWidget {
  const User_rating({super.key, this.id,});
  final id;
  @override
  State<User_rating> createState() => _User_ratingState();
}

class _User_ratingState extends State<User_rating> {




  double rating = 0;

  DocumentSnapshot? mech;

  getData() async {
    mech = await FirebaseFirestore.instance
        .collection("Mechrequest")
        .doc(widget.id)
        .get();
  }
  void payment(id) {
    FirebaseFirestore.instance.collection('Mechrequest').doc(id).update({
      'status':2,
      'rating':rating,

    }).then((value) =>  Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => User_rating()))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title:Text("Your Rating",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("Error${snapshot.error}");
            }
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),



                  Row(
                    children: [
                                             SizedBox(

                        child: RatingBar.builder(
                          itemSize: 70,
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) =>
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                          onRatingUpdate: (rating) {

                          },
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    height: 40,
                    width: 220,
                    child: ElevatedButton(onPressed: () {



                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(

                          backgroundColor: Colors.white,

                          title: Center(
                            child: Text("Add Rating"),
                          ),

                          titleTextStyle: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),

                          content: SizedBox(
                            height: 210,
                            width: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),

                                SizedBox(

                                  child: RatingBar.builder(
                                    itemSize: 40,
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) =>
                                        Icon(
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

                                // Text("$rating"),

                                Spacer(),
                                ElevatedButton(onPressed: (){

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const User_home()),
                                  );

                                }, child: Text("ok"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade400,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(19)),
                                  ),

                                ),
                              ],
                              ),
                          ),
                        ),
                      );


                    }, child: Text("Add rating"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
