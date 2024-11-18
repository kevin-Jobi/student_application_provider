// import 'package:student_application/db_helper/repository.dart';
// import 'package:student_application/model/User.dart';

// class UserService{
//   Repository _repository=Repository();
//   userService(){
//     _repository=Repository();
//   }
  
// // Save user
// saveUser(User user)async{
//   // print('Saved ${user.image}');
//   return await _repository.insertData('users', user.userMap());
// }
// // Edit user
// updateUser(User user)async{
  
//   return await _repository.updateData('users', user.userMap());
// }

// // Read All Users
// readAllUsers()async{
//   var a =await _repository.readData('users');
//   return a;

// }

  
// // 
// // deleteAllUsers(int key)async{
// //   return await _repository.deleteDataById('users',key);
// // }

// deleteUser(userId) async{
//   return await _repository.deleteDataById('users', userId);
// }
// }