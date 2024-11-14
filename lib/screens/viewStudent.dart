import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_application/model/User.dart';


class ViewStudent extends StatefulWidget {
  final User user   ;
  const ViewStudent({super.key,required this.user});

  @override
  State<ViewStudent> createState() => _ViewStudentState();
}

class _ViewStudentState extends State<ViewStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite CRUD'),
        // backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Text('Full Details',
              style:  TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
                fontSize: 20
              ),
              ),
              Row(
                
                children: [
                  const Text('Name',
                  style: TextStyle( 
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                  Padding(
                     padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.user.name??'',
                    style: 
                    TextStyle(fontSize: 16),),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                
                children: [
                  const Text('Contact',
                  style: TextStyle( 
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.user.contact??'',
                    style: 
                    TextStyle(fontSize: 16),),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
        
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Description',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.user.description??'',
                  style: 
                  const TextStyle(fontSize: 16),)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
                Row(
                
                children: [
                  const Text('BloodGroup',
                  style: TextStyle( 
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.user.bloodgroup??'',
                    style: 
                    TextStyle(fontSize: 16),),
                  )
                ],
              ),
              
               const SizedBox(
                height: 20,
              ),
                
              // Displaying the image
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Image',
                  style: TextStyle( 
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                  ),
                   const SizedBox(
                height: 10,
              ),
                  if (widget.user.image != null) ...[
                Image.file(
                  File(widget.user.image!), // Assuming image path is stored in user.image
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
               
              ],
                ],
              )
              
            ],
          ),
        ),
      ),
    );
  }
}