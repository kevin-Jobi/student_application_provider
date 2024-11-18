import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:student_application/model/User.dart';

late Database db;

class StudentDbHelper {
  List<StudentModel> students = [];
  Future<void> initialiseDatabase() async {
    try {
      db = await openDatabase(
        'student_db',
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE studentDb (id INTEGER PRIMARY KEY,name TEXT,contact TEXT,description TEXT,image TEXT,bloodgroup TEXT)');
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  addStudent(StudentModel student) async {
    await db.rawInsert(
        'INSERT INTO studentDb(name,contact,description,image,bloodgroup) VALUES(?,?,?,?,?)',
        [
          student.name,
          student.contact,
          student.description,
          student.image,
          student.bloodgroup
        ]);
    log('added');
  }

  Future<List<StudentModel>> getAllStudents() async {
    final data = await db.rawQuery('SELECT * FROM studentDb');
    students = data.map((student) {
      return StudentModel.fromMap(student as Map<String, dynamic>);
    }).toList();
    return students;
  }

  delete(int id) async {
    try {
      await db.rawDelete('DELETE FROM studentDb WHERE id = ?', [id]);
      log('Deleted entry with id: $id');
    } catch (e) {
      log(e.toString());
    }
  }

  editStudentDetails(StudentModel editedDetails) async {
    try {
       await db.rawUpdate(
        'UPDATE studentDb SET name = ?, contact = ?, description = ?, image = ?, bloodgroup = ?  WHERE id = ?',
        [
          editedDetails.name,
          editedDetails.contact,
          editedDetails.description,
          editedDetails.image,
          editedDetails.bloodgroup,
          editedDetails.id,
        ]);
    log('edited');
    } catch (e) {
      log(e.toString()); 
    }
   
  }
}
