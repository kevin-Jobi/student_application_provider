// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_application/model/User.dart';
import 'package:student_application/screens/home.dart';
import 'package:student_application/servises/userService.dart';

class EditStudent extends StatefulWidget {
    EditStudent({required this.swift, super .key});
User swift;
  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  File? selectedImage;
  String Imagepath ='';
  var _userNameController=TextEditingController();
  var _userContactController=TextEditingController();
  var _userDescriptionController=TextEditingController();
  var _userbloodgroupController=TextEditingController();
  

  bool _validateName=false;
    bool _validateContact=false;
      bool _validateDescription=false;
      bool _validatebloodgroup=false;
      var _userService=UserService();
      @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _userNameController.text=widget.swift.name!;
//     _userContactController.text=widget.swift.contact!;
//     _userDescriptionController.text=widget.swift.description!;
//     selectedImage=File(widget.swift.image!);
// }
void initState(){
  // setState(() {
    _userNameController.text=widget.swift.name??'';
    _userContactController.text=widget.swift.contact??'';
    _userDescriptionController.text=widget.swift.description??'';
    _userbloodgroupController.text=widget.swift.bloodgroup??'';
    selectedImage=File(widget.swift.image!);
  // });
  super.initState();
}
      
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        title:const Text("SQLite CRUD"),),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: const Text(
                  'Edit Student Detail',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                  fontWeight: FontWeight.w500
                ),
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
                  child: selectedImage !=null
                   ?Image.file(
                    selectedImage!,
                    fit:BoxFit.cover,
                )
                :Text(
                  'Click pic in camera',
                  style: TextStyle(color: Colors.blue),
                ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: (){
                        picImageFromGallery();
                    }, icon: Icon(
                      Icons.camera_alt_outlined,
                    )
                    )
                  ],
                ),
              ),
              TextField(
                
                controller: _userNameController,
                decoration:  InputDecoration(
                  border:const OutlineInputBorder(),
                  hintText: 'Enter Name',
                  labelText: 'Name',
                  errorText: _userNameController.text.isEmpty ? 'Name Value Can\'t Be Empty' :null,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _userContactController,
                decoration:  InputDecoration(
                  border:const OutlineInputBorder(),
                  hintText: 'Enter Contact',
                  labelText: 'Contact',
                  errorText: _userContactController.text.isEmpty ? 'Contact Value Can\'t Be Empty' :null
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _userDescriptionController,
                decoration:  InputDecoration(
                  border:const OutlineInputBorder(),
                  hintText: 'Enter Description',
                  labelText: 'Description',
                  errorText: _userDescriptionController.text.isEmpty ? 'Description Value Can\'t Be Empty' :null
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userbloodgroupController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter BloodGroup',
                  labelText: 'BloodGroup',
                  errorText: _validatebloodgroup ? 'BloodGroup Value Cant\'t Be Empty' :null
                ),
              ),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal,
                      textStyle: const TextStyle(fontSize: 15)
                    ),
                    onPressed: ()async{
                  
                        _userNameController.text.isEmpty?_validateName=true:_validateName=false;
                        _userContactController.text.isEmpty?_validateContact=true:_validateContact=false;
                        _userDescriptionController.text.isEmpty?_validateDescription=true:_validateDescription=false;
                        _userbloodgroupController.text.isEmpty?_validatebloodgroup=true:_validatebloodgroup=false;
                        setState(() {
                          
                        });
         
                       if(_userNameController.text.length>0 &&
                        _userDescriptionController.text.isNotEmpty&&
                        _userContactController.text.isNotEmpty&&
                        _userbloodgroupController.text.isNotEmpty){
                          // print('Good data can save');
                          User _user =User();
                          _user.id=widget.swift.id;
                          _user.name = _userNameController.text;
                          _user.contact =_userContactController.text;
                          _user.description =_userDescriptionController.text;
                          _user.bloodgroup=_userbloodgroupController.text;
                          _user.image=selectedImage!.path;
                          var result=await _userService.updateUser(_user); 
                            //  Navigator.of(context).pop();
                            //  Navigator.pop(context); 
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyHomePage()), (Route<dynamic> route) => false);
        
                          // print(_user);
                           print('ithaaanu nokkunnee$result');
                        }else{
                                                   
                         final snackBar= SnackBar(content: Text('There should be a value in the text field'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar) ;
                         
                        }
                    },
                     child: const Text('Update Details')
                     ),
                    const SizedBox(
                width: 15.0,
              ),
                    TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(fontSize: 15)
                    ),
                    onPressed: (){
                      _userNameController.text='';
                      _userContactController.text='';
                      _userDescriptionController.text='';
                      _userbloodgroupController.text='';
                    }, child: const Text('Clear details'))
                ],
              )
          ],
          
          ),
        ),
      ),
    );
  }

  Future picImageFromGallery() async{
    final returnImage=
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if(returnImage == null){
      return;
    }
    setState(() {
      selectedImage =File(returnImage.path);
      Imagepath =returnImage.path.toString();
    });
  }
}