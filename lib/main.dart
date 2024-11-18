import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_application/db_helper/student_db.dart';
import 'package:student_application/providers/student_provider.dart';
import 'package:student_application/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await StudentDbHelper().initialiseDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => StudentProvider(),)],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.blueGrey),
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  MyHomePage(),
      ),
    );
  }
}

