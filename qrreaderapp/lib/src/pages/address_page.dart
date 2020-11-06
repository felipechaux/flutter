import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/utils/scan_util.dart' as utils;


class AddressPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    //return FutureBuilder<List<ScanModel>>(
    //future: DBProvider.db.getAllScans(),

    scansBloc.getScans();

    //Stream builder para patron bloc
    return StreamBuilder<List<ScanModel>>(
      //cada vez que existan cambios el stream se redibuja
        stream: scansBloc.scansStreamHttp,
        builder:
            (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final scans = snapshot.data;
          if (scans.length == 0) {
            return Center(child: Text('No hay informacion'));
          }

          //si hay informacion
          return ListView.builder(
              itemCount: scans.length,
              //Dismissible deslizar izquierda o derecha
              itemBuilder: (context, i) => Dismissible(
                //referencia UniqueKey llave unica flutter
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) =>
                  // DBProvider.db.deleteScan(scans[i].id),
                  //usando metodo de eliminacion de patron bloc
                  scansBloc.deleteScan(scans[i].id),
                  child: ListTile(
                    onTap: () => utils.launchScan(context, scans[i]),
                    leading: Icon(Icons.cloud_queue,
                        color: Theme.of(context).primaryColor),
                    title: Text(scans[i].value),
                    subtitle: Text('ID: ${scans[i].id}'),
                    trailing:
                    Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  )));
        });
  }
}
