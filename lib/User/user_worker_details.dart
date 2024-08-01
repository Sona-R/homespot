import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class User_worker_details extends StatefulWidget {
  const User_worker_details({super.key,required this.id});
  final id;

  @override
  State<User_worker_details> createState() => _User_worker_detailsState();
}


class _User_worker_detailsState extends State<User_worker_details> {


  @override
  void initState() {
    // TODO: implement initState
    getSavedData();
    super.initState();
    getSavedData();
  }
  var ID = '';


  Future<void>getSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();




    ID = prefs.getString('id')!;
    setState(() {

    });

  }






  final date = new DateTime.now();
  TimeOfDay time = TimeOfDay.now();


  String ?dropdownvalue;




  DocumentSnapshot?mech;
  getData() async {


    mech = await FirebaseFirestore.instance
        .collection("Mechsignup")
        .doc(widget.id)
        .get();
    getuser();
    print("get mech");
  }

  DocumentSnapshot?user;

  getuser() async {


    user= await FirebaseFirestore.instance
        .collection("Usersignup")
        .doc(ID)
        .get();
    print("get user");
  }

  var locationctrl = TextEditingController();





  Future<dynamic> mechrequest() async {
    print("object");
    await FirebaseFirestore.instance.collection('Mechrequest').add({

      "location": locationctrl.text,
      "service":dropdownvalue,
      "userprofile":user!['path'],
      "mechprofile":mech!['path'],
      "userusername":user!['username'],
      "username":mech!['username'],
      "time":time.format(context),
      "date":DateFormat('dd/MM/yyyy').format(date),
      "mechid":widget.id,
      "userid":ID,
      "payment":0,
      "status": 0,
      "phone":user!['phone'],
      "phone":mech!['phone'],
      "experience":mech!['experience']
    });
    print("done");
    Navigator.of(context).pop();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title:Text("Needed Service",style: TextStyle(fontWeight: FontWeight.bold),),
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
                    height: 10,
                  ),
                  SizedBox(
                      height: 130,
                      width: 130,
                      child: Image.asset("assets/images/person.jpg")),
                  SizedBox(
                    height: 15,
                  ),
                  Text(mech!['username'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),
                  SizedBox(
                    height: 15,
                  ),
                  Text(mech!['phone'], style: TextStyle(fontSize: 18),),
                  Text(mech!['experience'], style: TextStyle(fontSize: 18),),
                  SizedBox(
                    height: 7,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Available"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                    ),),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 180),
                    child: Text("Add needed service",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('services')
                              .where("mechid", isEqualTo: widget.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              List<String> tradeList = snapshot.data!.docs
                                  .map((DocumentSnapshot document) =>
                                  document['service'].toString())
                                  .toList();

                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: Colors.black54),
                                        borderRadius:
                                        BorderRadius.circular(8)),
                                    child: DropdownButton<String>(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 3),
                                      underline: const SizedBox(),
                                      borderRadius: BorderRadius.circular(10),
                                      hint: const Text(
                                          "choose your needed service"),
                                      value: dropdownvalue,
                                      // Set initial value if needed
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue= newValue!;
                                          print(dropdownvalue);
                                        });
                                      },

                                      items: tradeList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) =>
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        )
                      ],
                    ),

                    // child: Row(
                    //   children: [
                    //     Container(
                    //       color: Colors.green.shade50,
                    //
                    //       height: 60,
                    //       width: 300,
                    //       child:
                    //       DropdownButton(
                    //
                    //         value: dropdownvalue,
                    //
                    //         icon: const Icon(Icons.keyboard_arrow_down),
                    //
                    //         items: items.map((String items) {
                    //           return DropdownMenuItem(
                    //             value: items,
                    //             child: Text(items),
                    //           );
                    //         }).toList(),
                    //         onChanged: (String? newValue) {
                    //           setState(() {
                    //             dropdownvalue = newValue!;
                    //             print(dropdownvalue);
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     IconButton(onPressed: () {}, icon: Icon(
                    //         Icons.add_circle_rounded)),
                    //   ],
                    // ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 310),
                    child: Text("Place",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: Container(
                      height: 50,
                      width: 490,
                      color: Colors.red.shade50,
                      child: TextFormField(
                        controller: locationctrl,

                        decoration: InputDecoration(

                          border: InputBorder.none,

                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(15)
                          // ),

                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    height: 40,
                    width: 220,
                    child: ElevatedButton(onPressed: () {

                      mechrequest();
                    }, child: Text("Request"),
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
