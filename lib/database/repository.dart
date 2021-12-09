import 'package:lembra_do_remedio/database/database.dart';
import 'package:sqflite/sqflite.dart';

class Repository{

  ComprimidosDatabase _comprimidosDatabase = ComprimidosDatabase();
  static Database _database;

  //iniciar database
  Future<Database> get database async{
    if(_database != null) return _database;
    _database = await _comprimidosDatabase.setDatabase();
    return _database;
  }

  //inserir
  Future<int> insertData(String table,Map<String,dynamic> data) async{
    Database db = await database;
    try{
      return await db.insert(table, data);
    }catch(e){
      return null;
    }
  }

  //get todo database
  Future<List<Map<String,dynamic>>> getAllData(table) async{
    Database db = await database;
    try{
      return db.query(table);
    }catch(e){
      return null;
    }
  }

  //delete
  Future<int> deleteData(String table,int id) async{
    Database db = await database;
    try{
      return await db.delete(table,where: "id = ?", whereArgs: [id]);
    }catch(e){
      return null;
    }
  }


}