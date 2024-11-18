// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:student_application/model/User.dart';
// import 'package:student_application/screens/adduser.dart';
// import 'package:student_application/screens/editstudent.dart';
// import 'package:student_application/screens/viewStudent.dart';
// import 'package:student_application/servises/userService.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//  late  List<User> _userList=[];
//   final _userService=userService();

//  Future< List<User>> getAllUserDetails() async{
//     var users=await _userService.readAllUsers();
//     List<User> userList=[];
//     users.forEach((user){

//         var userModel=User();
//       userModel.id=user['id'];
//       userModel.name=user['name'];
//       userModel.contact=user['contact'];
//       userModel.description=user['description'];
//       userModel.image=user['image'];
//       userList.add(userModel);

//     });
//       return userList;
//   }
//   @override
//   void initState() {

//      print('imitstate');

//     super.initState();
//   }

// _showSucessSnackBar(String message){
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(message),
//       )
//       );
// }

// _deleteFormDialoge(BuildContext context,userId)async{
//   return showDialog(context: context, builder: (param){
//     return AlertDialog(
//       title: const Text('Are you sure to delete',
//       style: TextStyle(color: Colors.teal,fontSize: 20),
//       ),
//       actions: [
//         TextButton(
//           style: TextButton.styleFrom(
//             backgroundColor: Colors.red,
//             foregroundColor: Colors.white
//           ),
//           onPressed: ()async{
//             var result=await _userService.deleteUser(userId);
//             if(result !=null){
//               Navigator.pop(context);
//              await getAllUserDetails();
//               _showSucessSnackBar('User details deleted Success');
//             }
//           },
//          child: const Text('Delete')),
//          TextButton(
//           style: TextButton.styleFrom(
//             backgroundColor: Colors.teal,
//             foregroundColor: Colors.white
//           ),
//           onPressed: (){
//             Navigator.pop(context);
//           },
//          child: const Text('Close'))
//       ],
//     );
//   });
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("SQLite CRUD"),
//         backgroundColor: Colors.teal,
//       ),

//       body: FutureBuilder(future: getAllUserDetails(), builder: (context, snapshot) {

//         if(snapshot.data==null){
//           return Center(child: CircularProgressIndicator(),);
//         }
//         _userList=snapshot.data!;
//      return   ListView.builder(
//         itemCount: _userList.length,
//         itemBuilder: (context,index){
//           print('hiiiiiiiiiiiiiiii ${_userList[index].image}');
//           print('hiiiiiiiiiiiiiiii ${_userList[index].name}');
//           return Card(
//             child: ListTile(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewStudent(user:_userList[index])));
//               },
//               leading:_userList[index].image==null? Icon(Icons.person):CircleAvatar(child: Image(image:FileImage(File(_userList[index].image!)) ,),),
//               title: Text(_userList[index].name??''),

//               subtitle: Text(_userList[index].contact??''),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                 IconButton(
//                   onPressed: (){
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditStudent(swift: _userList[index]),))
//                     //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditStudent(swift: _userList[index])))
//                      .then((data)async {
//                       if(data!=null){
//                      _userList= await  getAllUserDetails();
//                         _showSucessSnackBar('User Detail Updated Sucess');
//                       }
//                     }
//                     );

//                   },
//                    icon:const Icon(Icons.edit,color: Colors.teal,) ),
//                    IconButton(
//                 //  onPressed: () async {
//                 //         print('strt hellow');
//                 //        var result = await _userService.deleteAllUsers(_userList[index].id!);
//                 //        if (result != null) {
//                 //     // Deletion operation completed successfully, now refresh the user list
//                 //          getAllUserDetails();
//                 //      }
//                 //      },
//                     onPressed: ()async{
//                      await _deleteFormDialoge(context,_userList[index].id);

//                       setState(() {

//                       });

//                     },

//                    icon:const
//                    Icon(Icons.delete,color: Colors.red,) )
//               ],

//               ),

//             ),
//           );
//         });
//       },),
//         floatingActionButton: FloatingActionButton(
//         onPressed:(){
//           Navigator.push(context,
//           MaterialPageRoute(builder: (context){
//             return AddUser(); })

//           ).then((data){
//             if(data !=null){
//               getAllUserDetails();
//               _showSucessSnackBar('User detail added Success');
//             }
//           } );
//         },
//         child:const Icon(Icons.add),
//          )
//         );

//   }
// }
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_application/model/User.dart';
import 'package:student_application/providers/student_provider.dart';
import 'package:student_application/screens/adduser.dart';
import 'package:student_application/screens/editstudent.dart';
import 'package:student_application/screens/viewstudent.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) :super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<StudentModel> _studentList = [];

  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<StudentProvider>(context, listen: false)
          .getAllStudentsProvider();
    });

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // implement the filter method
  void _filterStudents(String query){
    final provider = Provider.of<StudentProvider>(context,listen: false);
    provider.setSearchQuery(query);
     
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<StudentProvider>(context).getAllStudentsProvider();
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite CRUD"),
        backgroundColor: Colors.teal,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: 100,
              child: Consumer<StudentProvider>(
                builder: (context,provider,child){
                   return TextField(
                  onChanged: _filterStudents,
                  decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                );
                },
               
              ),
            ),
          ),
        ],
      ),
      body: Consumer<StudentProvider>(
        builder: (context, value, child) {
          // value.getAllStudentsProvider();
          _studentList =value.students as List<StudentModel>? ?? [];

          // List<StudentModel>filteredStudentList = _studentList.where((student){
          //   return student.name.toLowerCase().contains(_searchQuery.toLowerCase());
          //   // return student.name.toLowerCase().contains(value.searchQuery.toLowerCase());
          // }).toList();

          log(_studentList.length.toString());
          return value.students.isEmpty
              ? Center(
                  child: Text('No data'),
                )
              : ListView.builder(
                  // itemCount: value.students.length,
                  // itemCount: filteredStudentList.length,
                  itemCount: _studentList.length,
                  itemBuilder: (context, index) {
                    final StudentModel student = value.students[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewStudent(user: student)), //[index]
                                  // ViewStudent(user: filteredStudentList[index])),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          // File(filteredStudentList[index].image),
                          File(_studentList[index].image),
                        ),
                      ),
                      title: Text(_studentList[index].name),
                      subtitle: Text(_studentList[index].contact),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: ((context) => EditStudent(swift: student))));
                            },
                            icon: const Icon(Icons.edit, color: Colors.teal),
                          ),
                          IconButton(
                            onPressed: () async {
                              Provider.of<StudentProvider>(context, listen: false).deleteProvider(student.id!);
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddUser()))
              .then((data) {
            if (data != null) {
              // getAllUserDetails();
              // _showSucessSnackBar('User detail added Success');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
