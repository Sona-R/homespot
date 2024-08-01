
import 'package:flutter/material.dart';
import 'package:workers_app/User/user_login.dart';
import 'package:workers_app/workers/work_login.dart';

import 'Admin/admin_login.dart';

class Who extends StatefulWidget {
  const Who({super.key});

  @override
  State<Who> createState() => _WhoState();
}

class _WhoState extends State<Who> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              SizedBox(
                height: 280,
                width: 360,
                child: Image.asset("assets/images/onspot.jpeg"),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(right: 250),

                child: Text("Who you are",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
              ),
              SizedBox(
                height: 35,
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Work_Login()),
                  );
                }, child: Text("Worker",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              SizedBox(
                  width: 300,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const User_login()),
                    );
                  }, child: Text("User",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Admin_login()),
                );


              }, child: Text("Admin Login",style: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.bold,fontSize: 18),))
            ],
          ),
        ),
      ),
    );
  }
}
