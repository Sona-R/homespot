
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workers_app/User/user_home_worker.dart';
import 'package:workers_app/User/user_home_request.dart';
import 'package:workers_app/User/user_notification.dart';
import 'package:workers_app/User/user_profile.dart';
class User_home extends StatefulWidget {

  const User_home({Key? key}) : super(key: key);

  @override
  State<User_home> createState() => _User_homeState();
}

class _User_homeState extends State<User_home> {



  String? _selectedLocation = 'All Locations'; // Initial selection
  List<String> _locations = []; // Initial list with "All Locations"

  @override
  void initState() {
    super.initState();
    // Fetch locations from Firebase on initialization
    _fetchLocations();
  }

  // Function to fetch locations from Firebase
  void _fetchLocations() async {
    // Clear the list
    _locations.clear();
    // Add "All Locations" as the default option
    _locations.add('All Locations');

    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('Mechsignup').get();
    List<String> locations = [];
    querySnapshot.docs.forEach((doc) {
      locations.add(doc['location']);
    });
    setState(() {
      _locations.addAll(locations); // Add fetched locations to the list
    });
  }







  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade400,
          leading: InkWell(

            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => User_profile()),
              );
            },
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/person.jpg"),
            ),
          ),
          title:  DropdownButton<String>(
            dropdownColor: Colors.white,
            value: _selectedLocation,
            icon: Icon(Icons.arrow_drop_down),
            onChanged: (String? newValue) {
              setState(() {
                _selectedLocation = newValue;
              });
            },
            items: _locations.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){

              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const User_notification())
              );




            }, icon:Icon(Icons.notification_add,color: Colors.amber,))
          ],
        ),


        bottomSheet: Card(
          color: Colors.red.shade50,
          child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red.shade400
              ),

              tabs: [Tab(child: Text("Worker"),
              ),
                Tab(child:Text("Request") ,)
              ]),
        ),
        body:  TabBarView(children: [
          User_home_mechanic(
              selectedLocation: _selectedLocation == 'All Locations'
                  ? null
                  : _selectedLocation),

          User_home_request(),
        ]),
      ),
    );
  }
}












