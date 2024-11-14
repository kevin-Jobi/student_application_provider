import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection
{
  Future<Database> setDatabase()async{

    var directory=await getApplicationDocumentsDirectory();
    var path =join(directory.path,'db_crud');
    var database= await openDatabase(path,version: 1,onCreate: _createDatabase,);
    //  await upgrading(database, 1, 2);
    return database;
  }

  Future<void> _createDatabase(Database database, int version,) async{
    String sql=
    'CREATE TABLE users (id INTEGER PRIMARY KEY,name TEXT,contact TEXT,description TEXT,image TEXT,bloodgroup TEXT);';
  await database.execute(sql);
  }

}
//  upgrading(Database db,int oldversion,int newversion)async{
//     if (oldversion < 2) {
//       // Example of adding a new column
//       await db.execute('ALTER TABLE users ADD COLUMN bloodgroup TEXT');
//     }
//   }
// onUpgrade:upgrading 

