import 'package:flutter/material.dart';
import 'package:todo/util/mybuttons.dart';

// ignore: must_be_immutable
class Mydialog extends StatelessWidget {
  final controller;
VoidCallback onSave;
VoidCallback onCancel;


  Mydialog({super.key,
   required this.controller,
   required this.onSave,
   required this.onCancel
   });
 


  @override
  Widget build(BuildContext context) {
    return   AlertDialog(
      backgroundColor: Colors.grey[200],
      
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //text field
            TextField(
              controller: controller,
        
              decoration: InputDecoration(
                hintText: "Add a new task ",
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                
                )
                
                ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                children: [
                  //sav button
                  MyButton(text: "Save", onPressed:onSave                     
                  ,),

                  SizedBox(width: 20,),
            
                  // can button 
                  MyButton(text: "Cancel", onPressed: onCancel                 
                  )
                ],
              ),
            )

          ],
        ),
          
          
        
        

      ),
    );
  }
}

 
