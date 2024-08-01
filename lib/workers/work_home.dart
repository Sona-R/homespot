import 'package:flutter/material.dart';
import 'package:workers_app/workers/Work_request.dart';
import 'package:workers_app/workers/work_rating.dart';
import 'package:workers_app/workers/work_services.dart';



class Work_home extends StatefulWidget {
  const Work_home({super.key});

  @override
  State<Work_home> createState() => _Work_homeState();
}

class _Work_homeState extends State<Work_home> {
  int _indexNum=0;
  List tabs = [

   Work_request(),
    Work_services(),
    Work_rating()


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white
          ,
          items: [


            BottomNavigationBarItem(

              label: "Request",
              icon: Icon(Icons.person_search,color: Colors.red.shade400),
            ),
            BottomNavigationBarItem(

              label: "Service",
              icon: Icon(Icons.settings_rounded,color: Colors.red.shade400)
              ,),
            BottomNavigationBarItem(

                label: "Rating",
                icon: Icon(Icons.star,color: Colors.red.shade400))
          ],
          iconSize: 30,
          // showSelectedLabels: false,


          currentIndex: _indexNum,
          onTap: (int index){

            setState(() {
              _indexNum= index;
            });

          }
      ),
      body: tabs.elementAt(_indexNum),


    );
  }
}
