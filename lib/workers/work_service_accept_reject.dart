
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workers_app/workers/work_home.dart';
class Work_accept_reject extends StatefulWidget {
  const Work_accept_reject({super.key,required this.id});
  final id;

  @override
  State<Work_accept_reject> createState() => _Work_accept_rejectState();
}

class _Work_accept_rejectState extends State<Work_accept_reject> {

  DocumentSnapshot? user;

  getData() async {
    user = await FirebaseFirestore.instance
        .collection("Mechrequest")
        .doc(widget.id)
        .get();
  }

  void accept(id) {
    setState(() {
      FirebaseFirestore.instance
          .collection("Mechrequest")
          .doc(id)
          .update({'status': 1});
      print("accept");
    });
  }

  void rejects(id) {
    setState(() {
      FirebaseFirestore.instance
          .collection("Mechrequest")
          .doc(id)
          .update({'status': 2});
      print("Rejected");
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Work_home())
          );
        }, icon:Icon(Icons.arrow_back),iconSize: 25,),
      ),

      body: FutureBuilder(

        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("Error${snapshot.error}");
          }

          return Center(
            child: Container(
              height: 500,
              width: 310,
              child: Card(
                color: Colors.red.shade50,
                child: Column(
                  children: [

                    user!['userprofile']==''?

                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: ExactAssetImage(
                          "assets/images/person.jpg"),
                    )
                        :

                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          user!["userprofile"]),


                    ),



                     Text(user?['userusername'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 65),
                      child: Row(
                        children: [
                          Text("Problem  :", style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),),
                           Text(user?['service'])
                        ],

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 65),
                      child: Row(
                        children: [
                          Text("Place  :", style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),),
                          Text(user?['location'])
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 65),
                      child: Row(
                        children: [
                          Text("Date  :", style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),),
                          Text(user?['date'])
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 65),
                      child: Row(
                        children: [
                          Text("Time  :",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                          Text(user?['time'])
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 65),
                      child: Row(
                        children: [
                          Text("Contact number  :", style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),),
                          Text(user?['phone'])
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),



                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(left: 55,),
                      child:user!['status']==0? Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              accept(widget.id);
                            },
                            child: Text("Accept"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              rejects(widget.id);
                            },
                            child: Text("Reject"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ],
                      ):user!["status"]==1? Padding(
                        padding: const EdgeInsets.only(right: 55),
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          child: Text("Accepted"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ): Padding(
                        padding: const EdgeInsets.only(right: 60),
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          child: Text("rejected"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
