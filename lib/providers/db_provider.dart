import 'dart:io';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/scan_model.dart';

class DBProvider {
  static Database? _database;
  //creamos la instancia, el ._ es un constructor privado,
  //esto nos sirve para que siempre que creemos una nueva instancia,
  //obtengamos la misma instancia de la base de datos
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    //Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    //crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
            CREATE TABLE Scans(
              id INTEGER PRIMARY KEY,
              tipo TEXT,
              valor TEXT
            );        
        ''');
      },
    );
  }

  //forma en crudo raw (menos usada)
  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final db = await database;
    final res = db!.rawInsert('''
          INSERT INTO Scans ( id, tipo, valor)
          VALUES ( $id, '$tipo', '$valor')
          ''');
    return res;
  }

  //forma rapida de insertar en la base
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db!.insert('Scans', nuevoScan.toJson());
    print(res);
    //res es el id del ultimo registro insertado
    return res;
  }

  //metodo que nos permite recuperar un registro mediante
  //un id, y lo mapeamos al ScanModel
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db?.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res!.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  //metodo que regresa todos los scan
  Future<List<ScanModel>?> getTodosLosScans() async {
    final db = await database;
    final res = await db?.query('Scans');

    return res!.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        : null;
  }

  //Metodo para traer los scans por tipo
  Future<List<ScanModel>?> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db?.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'

''');

    return res!.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        : null;
  }

  //Metodo para actualizar un registro
  Future<int> updateScan(ScanModel) async {
    final db = await database;
    final res = await db.update('Scans', )
  } 
}
