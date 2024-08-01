
import 'package:flutter/material.dart';
import 'package:workers_app/Admin/adim_home_tab.dart';

import 'admin_notification.dart';
import 'admin_payment.dart';
class Admin_home extends StatefulWidget {
  const Admin_home({super.key});

  @override
  State<Admin_home> createState() => _Admin_homeState();
}

class _Admin_homeState extends State<Admin_home> {
  int _indexNum=0;
  List tabs = [
    Home_tab(),
    Admin_payment(),
    Admin_notification(),


  ];
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade400,
          leading: CircleAvatar(
            backgroundImage: ExactAssetImage("assets/images/person.jpg"),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home,color: Colors.red.shade400,),
              ),
              BottomNavigationBarItem(
                label: "Payment",
                icon: Icon(Icons.payments,color: Colors.red.shade400)
                ,),
              BottomNavigationBarItem(
                  label: "notification",
                  icon: Icon(Icons.notification_add,color: Colors.red.shade400))
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

      ),








    );
  }
}
