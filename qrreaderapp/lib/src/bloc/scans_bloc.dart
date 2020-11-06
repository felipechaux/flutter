import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

//uso de mixin - validators
class ScansBloc with Validators{
  //unica instancia
  static final ScansBloc _singleton = new ScansBloc._internal();

  //factory retornar cualquier cosa
  factory ScansBloc() {
    return _singleton;
  }
  //constructor privado
  ScansBloc._internal() {
    //obtener scans de la bd
    getScans();
  }

  //flujo de informacion
  final _scansController = StreamController<List<ScanModel>>.broadcast();

  //init escuchador - transformer geolocations
  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validateGeo);

  //transformer direcciones http
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validateHttp);


  dispose() {
    _scansController?.close();
  }

  getScans() async {
    _scansController.sink.add(await DBProvider.db.getAllScans());
  }

  //al agregar notifica al stream
  addScan(ScanModel scan) async {
    await DBProvider.db.newScan(scan);
    getScans();
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    //lo mismo _scansController.sink.add([]);
    getScans();
  }
}
