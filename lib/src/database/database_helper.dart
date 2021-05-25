

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:practica2_2021/src/models/favoritedao.dart';
import 'package:practica2_2021/src/models/userdao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _nombreBD = "MOVIESDB";
  static final _versionDB = 1;

  static Database _database;

  Future<Database> get database async{
    if(_database != null) 
      return _database; //Si ya está apuntando a algo, retornar, sino, inicializar
    else{
      _database = await _initDatabase(); //Apertura de la bd
      return _database;
    }
  }

  //retorna la apertura de la BD
 _initDatabase() async{
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaDB = join(carpeta.path, _nombreBD);
    return await openDatabase(
      rutaDB,
      version: _versionDB,
      onCreate: _scriptDB,//Cuando se instala por primera vez la aplicacion
    );
  }


  _scriptDB(Database db, int version) async{
      
       String script1="CREATE TABLE tbl_perfil(id INTEGER PRIMARY KEY, nomusr VARCHAR(25), apepat VARCHAR(25), apemat VARCHAR(25), telusr CHAR(10), mailusr VARCHAR(35), photousr varchar(200))";
       String script2="CREATE TABLE tbl_favorite(id INTEGER, backdrop_path VARCHAR(100), overview VARCHAR(500), poster_path VARCHAR(100), title VARCHAR(100), vote_average DECIMAL(10,2), email VARCHAR(35), PRIMARY KEY (id,email))";
      db.execute(script1);
      print('Ejecute el primero');
      db.execute(script2);
      print('Ejecute el segundo');
    
  }
  
  
  Future<int> insert(String table, Map<String, dynamic> values) async{ //int: Cuántas filas se afectaron
    var conexion = await database;
    return await conexion.insert(table, values);
  }
  //indicará cuántas filas fueron afectadas
  Future<int> update(String table, Map<String, dynamic> values) async {
    //database es un método
    var conexion = await database;
    //ejecutar un update en la conexión
    //retorna un valor de tipo int
    return await conexion.update(table, values, where:'id = ?', whereArgs: values['id'] );
  }
  Future<int> delete(String table, int id) async {
    var conexion = await database;
    conexion.delete(table, where: 'id = ?', whereArgs:[id]);
  }
  
  Future<UserDAO> getUser(String email) async {
    //devolverá el usuario
    var conexion = await database;
    var result = await conexion.query('tbl_perfil', where:'mailusr = ?', whereArgs:[email]);
    var lista = (result).map((user) => UserDAO.fromJSON(user)).toList();
    return lista.length > 0 ? lista[0] : null;

  }
   Future<FavoriteDAO> getMovie(int id) async {
    //devolverá el usuario
    var conexion = await database;
    var result = await conexion.query('tbl_favorite', where:'id = ?', whereArgs:[id]);
    var lista = (result).map((user) => FavoriteDAO.fromJSON(user)).toList();
    print('entre al get de fav: $lista');
    return lista.length > 0 ? lista[0] : null;

  }
  Future<List<FavoriteDAO>> getFavorite(String email) async {
    print('email get: $email');
    //devolverá el usuario
    var conexion = await database;
    var result = await conexion.query('tbl_favorite', where:'email = ?', whereArgs:[email]);
    var lista = (result).map((movie) => FavoriteDAO.fromJSON(movie)).toList();
    print('lista: $lista');
    return lista.length > 0 ? lista : null;
    

  }

  

}