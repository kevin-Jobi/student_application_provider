// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_application/model/User.dart';
import 'package:student_application/providers/student_provider.dart';

class EditStudent extends StatefulWidget {
  EditStudent({required this.swift, super.key});
  StudentModel swift;
  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  // File? selectedImage;
  // String Imagepath = '';
  var _userNameController = TextEditingController();
  var _userContactController = TextEditingController();
  var _userDescriptionController = TextEditingController();
  var _userbloodgroupController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late StudentProvider instance;
  @override
  void initState() {
    _userNameController.text = widget.swift.name;
    _userContactController.text = widget.swift.contact;
    _userDescriptionController.text = widget.swift.description;
    _userbloodgroupController.text = widget.swift.bloodgroup;

    instance = Provider.of<StudentProvider>(context, listen: false);

    instance.selectedImage = File(widget.swift.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite CRUD"),
      ),
      body: Consumer<StudentProvider>(
          builder: (BuildContext context, value, Widget? child) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: const Text(
                      'Edit Student Detail',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      height: 180,
                      width: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/bat.jpg'),
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: value.selectedImage != null
                          ? Image.file(
                              // selectedImage!,
                              value.selectedImage!,
                              fit: BoxFit.cover,
                            )
                          : Text(
                              'Click pic in camera',
                              style: TextStyle(color: Colors.blue),
                            ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              // var instance = Provider.of<StudentProvider>(context);
                              //  instance.picImageFromGallery();
                              Provider.of<StudentProvider>(context,
                                      listen: false)
                                  .picImageFromGallery();
                            },
                            icon: Icon(
                              Icons.camera_alt_outlined,
                            ))
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter Name',
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name Value Can\'t Be Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: _userContactController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter Contact',
                      labelText: 'Contact',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Contact Value Can\'t Be Empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _userDescriptionController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter Description',
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Description Value Can\'t Be Empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _userbloodgroupController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter BloodGroup',
                      labelText: 'BloodGroup',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'BloodGroup Value Cant\'t Be Empty';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.teal,
                              textStyle: const TextStyle(fontSize: 15)),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final student = StudentModel(
                                  name: _userNameController.text,
                                  contact: _userContactController.text,
                                  description: _userDescriptionController.text,
                                  image: value.selectedImage!.path,
                                  bloodgroup: _userbloodgroupController.text,
                                  id: widget.swift.id);
                              Provider.of<StudentProvider>(context,
                                      listen: false)
                                  .editProvier(student);
                              _userNameController.clear();
                              _userContactController.clear();
                              _userDescriptionController.clear();
                              _userbloodgroupController.clear();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Update Details')),
                      const SizedBox(
                        width: 15.0,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                              textStyle: const TextStyle(fontSize: 15)),
                          onPressed: () {
                            _userNameController.text = '';
                            _userContactController.text = '';
                            _userDescriptionController.text = '';
                            _userbloodgroupController.text = '';
                          },
                          child: const Text('Clear details'))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
