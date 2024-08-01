import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Admin_add_rejectreason extends StatefulWidget {
  const Admin_add_rejectreason({super.key});

  @override
  State<Admin_add_rejectreason> createState() => _Admin_add_rejectreasonState();
}

class _Admin_add_rejectreasonState extends State<Admin_add_rejectreason> {
  final _formkey=GlobalKey<FormState>();


  var contentctrl =TextEditingController();
  final date = new DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  Future<dynamic> submit() async{
      await FirebaseFirestore.instance.collection("Rejectreason").add({

      "content":contentctrl.text,
      "time":time.format(context),
      "date":DateFormat('dd/MM/yyyy').format(date),

      "status": 0
    }).then((value){
      print("success");

      Navigator.pop(context);
    });

    contentctrl.clear();

  }
  final SnackBar _snackBar=SnackBar(content: Text("successfully submitted"),duration: Duration(seconds: 3),);




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 100,),


              SizedBox(height: 30,),
              Padding(
                  padding: const EdgeInsets.only(right: 270),
                 child: Text("Enter content",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(




                  height: 200,



                  child: TextFormField(
                    controller: contentctrl,
                    validator:  (value) {
                      if (value == null || value.isEmpty) {   // Validation Logic
                        return 'required';
                      }
                      return null;
                    },
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: "content.....",
                        filled: true,
                        fillColor: Colors.red.shade50,
                        focusedBorder: UnderlineInputBorder(

                          borderRadius: BorderRadius.circular(10),



                        ),
                        border: InputBorder.none
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 180,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(onPressed: (){
                  if(_formkey.currentState!.validate()) {
                    submit();
                    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                  }


                }, child: Text("Submit",style: TextStyle(fontWeight: FontWeight.bold),
                ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                ),
              ),





            ],
          ),
        ),
      ),
    );
  }
}
