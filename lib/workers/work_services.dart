// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// class Mech_service extends StatefulWidget {
//   const Mech_service({super.key});
//
//   @override
//   State<Mech_service> createState() => _Mech_serviceState();
// }
//
// class _Mech_serviceState extends State<Mech_service> {
//
//
//
//
//
//   var servicectrl = TextEditingController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getmechdetails();
//   }
//
//   var ID = '';
//
//   void getmechdetails() async {
//     final mechservice = await SharedPreferences.getInstance();
//
//     ID = mechservice.getString('id')!;
//
//     setState(() {});
//   }
//
//   final _key = GlobalKey<FormState>();
//
//   final Snack =
//   SnackBar(duration: Duration(seconds: 3), content: Text("Service added"));
//
//   Future<dynamic> Submitservice() async {
//     await FirebaseFirestore.instance
//         .collection('services')
//         .add({'service': servicectrl.text, 'mechid': ID}).then((value) {
//       Navigator.pop(context);
//       servicectrl.clear();
//     });
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed:(){
//
// showDialog(context: context, builder: (BuildContext context)=>AlertDialog(
//
//
//   backgroundColor: Colors.blue.shade100,
//   title: Text("Add service",style: TextStyle(fontWeight: FontWeight.bold),),
//   content: Padding(
//     padding: const EdgeInsets.all(12.0),
//     child: Container(
//
//
//       decoration: BoxDecoration(
//         color: Colors.white,
//           border: Border.all(color: Colors.white)
//       ),
//
//
//       height: 60,
//
//
//
//       child: TextFormField(
//         controller: servicectrl,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return '*Required';
//           }
//           return null;
//         },
//         maxLines: 2,
//         decoration: InputDecoration(
//
//
//             border: InputBorder.none
//
//         ),
//       ),
//     ),
//   ),
//   actions: [Center(
//     child: SizedBox(
//       height: 30,
//       width: 150,
//       child: ElevatedButton(onPressed: (){
//
//         if (_key.currentState!.validate()) {
//           Submitservice();
//           ScaffoldMessenger.of(context)
//               .showSnackBar(Snack);
//         }
//       }, child: Text("Add"),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10)
//           ),
//         ),
//       ),
//     ),
//   )],
// ),);
//
//         } ,child: Icon(Icons.add),),
//       appBar: AppBar(
//         backgroundColor: Colors.blue.shade200,
//         title: Text("Service",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
//           child: Card(
//             color: Colors.lightBlue.shade50,
//             child: FutureBuilder(
//
//     future: FirebaseFirestore.instance
//         .collection('services')
//         .where('mechid', isEqualTo: ID)
//         .get(),
//     builder: (BuildContext context,
//     AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//       if (snapshot.hasError) {
//         return Center(
//           child: Text("Error:${snapshot.error}"),
//         );
//       }
//       final serv = snapshot.data?.docs ?? [];
//
//
//       return ListView.separated(
//           separatorBuilder: (context, index) =>
//               Divider(thickness: 1, color: Colors.black,),
//           itemCount:  serv.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               title: Text(serv[index]['service'], style: TextStyle(fontSize: 17),),
//               trailing: IconButton(
//                 onPressed: () {},
//                 icon: Icon(Icons.delete),
//                 iconSize: 26,
//               ),
//             );
//           }
//       );
//     },
//             ),
//           ),
//         ),
//       ),
//
//     );
//   }
// }




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Work_services extends StatefulWidget {
  const Work_services({super.key});

  @override
  State<Work_services> createState() => _Work_servicesState();
}

class _Work_servicesState extends State<Work_services> {
  var servicectrl = TextEditingController();



  void delete(id){
    FirebaseFirestore.instance
        .collection('services')
        .doc(id)
        .delete()
        .then((value) {
      setState(() {});
    }).catchError((error){
      print("failed to delete service: $error");

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmechdetails();
  }

  var ID = '';

  void getmechdetails() async {
    final mechservice = await SharedPreferences.getInstance();

    ID = mechservice.getString('id')!;

    setState(() {});
  }

  final _key = GlobalKey<FormState>();

  final Snack =
  SnackBar(duration: Duration(seconds: 3), content: Text("Service added"));

  Future<dynamic> Submitservice() async {
    await FirebaseFirestore.instance
        .collection('services')
        .add({'service': servicectrl.text, 'mechid': ID}).then((value) {
      Navigator.pop(context);
      servicectrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(

        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: Colors.red.shade50,
                title: Center(
                  child: Text("Add service"),
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
                      Form(
                        key: _key,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*Required';
                            }
                            return null;
                          },
                          controller: servicectrl,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                  ))),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: Colors.red.shade400,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              Submitservice();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(Snack);
                            }
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                ),
              ));
        },
        child: Icon(size: 40, Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title: Text(
          "Services",
          style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Card(
            color: Colors.red.shade50,
            child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('services')
                    .where('mechid', isEqualTo: ID)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  final serv = snapshot.data?.docs ?? [];
                  return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      itemCount: serv.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            serv[index]['service'],
                            style: TextStyle(fontSize: 19),
                          ),
                          trailing: IconButton(
                            onPressed: (){
                              delete(serv[index].id);
                            },
                            icon: Icon(Icons.delete),
                            iconSize: 27,
                          ),
                        );
                      });
                }),
          ),
        ),
      ),
    );
  }
}
