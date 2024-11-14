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
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_application/model/User.dart';
import 'package:student_application/screens/adduser.dart';
import 'package:student_application/screens/editstudent.dart';
import 'package:student_application/screens/viewStudent.dart';
import 'package:student_application/servises/userService.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
   List<User> _userList = [];
  final _userService = UserService();
  String _searchQuery = '';

  Future<List<User>> getAllUserDetails() async {
    // halloe();

    List<Map> users = await _userService.readAllUsers();
     print("this is users $users");
    List<User> userList = [];   
 
    users.forEach((user) {
        User userModel = User();
      
      userModel.id = user['id'];
      userModel.name = user['name'];
      userModel.contact = user['contact'];
      userModel.description = user['description'];
      userModel.image = user['image'];
      userModel.bloodgroup=user['bloodgroup'];
      

      
      userList.add(userModel);
    });
    return userList;
  }

  void _filterUsers(String query) {
    setState(() {
      _searchQuery = query;
    });
  }
_showSucessSnackBar(String message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      )
      );
}
_deleteFormDialoge(BuildContext context,userId)async{
  return showDialog(context: context, builder: (param){
    return AlertDialog(
      title: const Text('Are you sure to delete',
      style: TextStyle(color: Colors.teal,fontSize: 20),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white
          ),
          onPressed: ()async{
            var result=await _userService.deleteUser(userId);
            if(result !=null){
              Navigator.pop(context);
             await getAllUserDetails();
              _showSucessSnackBar('User details deleted Success');
            }
          },
         child: const Text('Delete')
         ),
         TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white
          ),
          onPressed: (){
            Navigator.pop(context);
          },
         child: const Text('Close'))
      ],
    );
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite CRUD"),
        // backgroundColor: Colors.teal,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: 100,
              child: TextField(
                onChanged: _filterUsers,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                 border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getAllUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          _userList = snapshot.data as List<User>? ?? [];
          // Filter the user list based on the search query
          List<User> filteredUserList = _userList.where((user) {
            return user.name!.toLowerCase().contains(_searchQuery.toLowerCase());
          }).toList();
          if(filteredUserList.isEmpty){
            return Center(child: Text("No data"),);
          }
          return ListView.builder(
            itemCount: filteredUserList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewStudent(user: filteredUserList[index])),
                  );
                },
                leading: filteredUserList[index].image == null
                    ? const Icon(Icons.person)
                    : CircleAvatar(
                        backgroundImage: FileImage(File(filteredUserList[index].image!),),
                      ),
                title: Text(filteredUserList[index].name ?? ''),
                subtitle: Text(filteredUserList[index].contact ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditStudent(swift: filteredUserList[index]),))
                          .then((data) async {
                            if (data != null) {
                              setState(() {
                                _userList = getAllUserDetails() as List<User>;
                              });
                              _showSucessSnackBar('User Detail Updated Success');
                            }
                          });
                      },
                      icon: const Icon(Icons.edit, color: Colors.teal),
                    ),
                    IconButton(
                      onPressed: () async {
                        await _deleteFormDialoge(context, filteredUserList[index].id);
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddUser())).then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSucessSnackBar('User detail added Success');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

