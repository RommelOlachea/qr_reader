import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  //creamos la instancia, el ._ es un constructor privado,
  //esto nos sirve para que siempre que creemos una nueva instancia,
  //obtengamos la misma instancia de la base de datos
  static final DBProvider db = DBProvider._();
  DBProvider._();
}
