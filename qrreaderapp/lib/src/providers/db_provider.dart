import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
//export - exponer modelo a los archivos que importen dbprovider
export 'package:qrreaderapp/src/models/scan_model.dart';

//singleton para solo una instancia

class DBProvider {
  static Database _database;
  //no se reinicializa --------- constructor privado
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentDirectory.path, 'ScansDB.db');

    return await openDatabase(path,
        version: 1,
        onOpen: (db) => {},
        onCreate: (Database db, int version) async {
          //creacion de tabla
          await db.execute('CREATE TABLE Scans ('
              ' id INTEGER PRIMARY KEY,'
              ' type TEXT,'
              ' value TEXT'
              ')');
        });
  }

  //crear registros
  newScanRaw(ScanModel newScan) async {
    final db = await database;

    final res = await db.rawInsert("INSERT INTO Scans (id,type,value) "
        "VALUES (${newScan.id},${newScan.type},${newScan.value})");

    return res;
  }

  //mas simplificado - mas segura
  newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert('Scans', newScan.toJson());
    return res;
  }

  //SELECT - obtener informacion
  Future<ScanModel> getScanId(int id) async {
    //se comprueba que se puede escribir en la bd
    final db = await database;
    final res = await db.query('Scans', where: 'id=?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    List<ScanModel> list =
        res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<ScanModel>> getAllScansByType(String type) async {
    final db = await database;
    // raw query
    final res = await db.rawQuery("SELECT * FROM Scans WHERE type='$type'");

    //cada iteracion crea instancias gracias al fromJson
    List<ScanModel> list =
        res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];
    return list;
  }

  //Actualizar Registros
  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.update('Scans', newScan.toJson(),
        where: 'id=?', whereArgs: [newScan.id]);

    return res;
  }

  //Eliminar Registros
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id=?', whereArgs: [id]);

    return res;
  }

  //Eliminar todos los registros
  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Scans');

    return res;
  }
}
