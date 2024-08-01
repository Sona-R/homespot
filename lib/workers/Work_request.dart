

import 'package:flutter/material.dart';

import 'Work_edit_profile.dart';
import 'Work_home_accepted.dart';
import 'Work_home_requests.dart';

class Work_request extends StatefulWidget {
  const Work_request({super.key,});

  @override
  State<Work_request> createState() => _Work_requestState();
}

class _Work_requestState extends State<Work_request> {






  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
     child:
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red.shade400,
              leading: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Work_edit_profile()),
                  );
                },
                child: CircleAvatar(

                  backgroundImage: ExactAssetImage("assets/images/person.jpg"),
                ),
              ),


            ),
            body: Column(
              children: [

                Card(
                  color: Colors.red.shade50
                  ,
                  child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red.shade400
                      ),

                      tabs: [Tab(child: Text("Requests"),
                      ),
                        Tab(child: Text("Accepted"),)
                      ]),
                ),
                Expanded(
                  child: TabBarView(children: [
                    work_home_request(),
                    Work_home_accepted(),
                  ]),
                )
              ],
            ),

          ),
          );


  }
}
