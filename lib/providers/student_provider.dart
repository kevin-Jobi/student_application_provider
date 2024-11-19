import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_application/db_helper/student_db.dart';
import 'package:student_application/model/User.dart';

class StudentProvider extends ChangeNotifier {
  final StudentDbHelper studentDb = StudentDbHelper();
  List<StudentModel> students = [];
  List<StudentModel> allStudents = [];
    File? selectedImage;
  String searchQuery = ''; // Add this line to store search query *Claude
  Future<void> addStudentProvider(StudentModel studentModel) async {
    await studentDb.addStudent(studentModel);
    await getAllStudentsProvider();
    notifyListeners();
  }

  Future<void> getAllStudentsProvider() async {
    // students.clear();
    students = await studentDb.getAllStudents();
    notifyListeners();
  }

  deleteProvider(int id) async {
    await studentDb.delete(id);
    getAllStudentsProvider();
    notifyListeners();
  }

  editProvier(StudentModel edited) async {
    await studentDb.editStudentDetails(edited);
    getAllStudentsProvider();
    notifyListeners();
  }

    Future picImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) {
      return;
    }
   
      selectedImage = File(returnImage.path);
      // Imagepath = returnImage.path.toString();
      notifyListeners();
  }

//

  // void getAllStudentProvider() async {
  //   students = await studentDb.getAllStudents();
  //   allStudents = List.from(students); // Keep a copy of all students
  //   notifyListeners();
  // }

  // void searchStudents(String query) {
  //   if (query.isEmpty) {
  //     students = List.from(allStudents); // Reset to full list if query is empty
  //   } else {
  //     students = allStudents
  //         .where((student) =>
  //             student.name.toLowerCase().contains(query.toLowerCase()) ||
  //             student.contact.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //   }
  //   notifyListeners();
  // }

  void setSearchQuery(String query) async {
    log('query is ${query}');
    searchQuery = query;

    if (searchQuery.isNotEmpty) {
     await getAllStudentsProvider();
      students = students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()) ||
              student.contact.toLowerCase().contains(query.toLowerCase()))
          .toList();
      log('students is${students.contains(query)}');
    } else {
      log('searchQuery is empty');
      // await getAllStudentsProvider();
    }
    notifyListeners();
  }
}
