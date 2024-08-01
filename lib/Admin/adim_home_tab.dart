import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workers_app/Admin/admin_home_worker.dart';

import 'admin_home_user.dart';



class Home_tab extends StatefulWidget {
  const Home_tab({super.key});

  @override
  State<Home_tab> createState() => _Home_tabState();
}

class _Home_tabState extends State<Home_tab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body: Column(
          children: [

            Card(
              color: Colors.red.shade100,
              child: TabBar(


                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.shade400
                  ),

                  tabs: [Tab(child: Text("User"),
                  ),
                    Tab(child:Text("Worker") ,)
                  ]),
            ),
            Expanded(
              child: TabBarView(children: [
                Admin_home_user(),
                Admin_home_worker(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
