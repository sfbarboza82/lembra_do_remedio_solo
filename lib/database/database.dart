import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ComprimidosDatabase{

  setDatabase() async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath,"db_comprimidos");
    Database database = await openDatabase(path,version: 1,onCreate: (Database db,int version)async{
      await db.execute("CREATE TABLE Comprimidos (id INTEGER PRIMARY KEY, nome TEXT, quantidade TEXT, tipo TEXT, diasRecorrentes INTEGER, formMedicamento TEXT, tempo INTEGER, idNotificacao INTEGER)");
    });
    return database;
  }

}