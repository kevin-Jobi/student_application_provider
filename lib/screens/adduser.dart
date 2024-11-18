import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_application/db_helper/student_db.dart';
import 'package:student_application/model/User.dart';
import 'package:student_application/providers/student_provider.dart';
import 'package:student_application/screens/home.dart';
import 'package:student_application/servises/userService.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  File? selectedImage;
  String Imagepath = '';
  var _userNameController = TextEditingController();
  var _userContactController = TextEditingController();
  var _userDescriptionController = TextEditingController();
  var _userbloodgroupController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // bool _validateName = false;
  // bool _validateContact = false;
  // bool _validateDescription = false;
  // bool _validatebloodgroup = false;

  // var _userService=UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite CRUD"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: const Text(
                    'Add Student Detail',
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
                    child: selectedImage != null
                        ? Image.file(
                            selectedImage!,
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
                            picImageFromGallery();
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
                                image: selectedImage!.path,
                                bloodgroup: _userbloodgroupController.text);
                            Provider.of<StudentProvider>(context, listen: false)
                                .addStudentProvider(student);
                            _userNameController.clear();
                            _userContactController.clear();
                            _userDescriptionController.clear();
                            _userbloodgroupController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Save Details')),
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
                        child: const Text('Clear details')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future picImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(returnImage.path);
      Imagepath = returnImage.path.toString();
    });
  }
}
