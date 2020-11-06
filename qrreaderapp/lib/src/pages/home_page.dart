import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/pages/address_page.dart';
import 'package:qrreaderapp/src/pages/maps_page.dart';
//import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'package:qrreaderapp/src/utils/scan_util.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  //lamada a patron bloc
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('QR Scanner'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: scansBloc.deleteAllScans)
          ],
        ),
        bottomNavigationBar: _createBottomNavigationBar(),
        body: _callPage(currentPage),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.filter_center_focus),
            onPressed: () => _scanQR(context)));
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      //elemento activo
      currentIndex: currentPage,
      onTap: (index) {
        setState(() {
          currentPage = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Maps')),
        BottomNavigationBarItem(
            icon: Icon(Icons.cloud_circle), title: Text('Address'))
      ],
    );
  }

  Widget _callPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return MapsPage();
      case 1:
        return AddressPage();

      default:
        return MapsPage();
    }
  }

  _scanQR(BuildContext context) async {
    ScanResult futureString;

    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString() as ScanResult;
    }

    if (futureString != null) {
      final scan = ScanModel(value: futureString.rawContent);
      // DBProvider.db.newScan(scan);
      //patron bloc - agregar a flujo
      scansBloc.addScan(scan);

      //esperar solo en IOS
      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.launchScan(context, scan);
        });
      } else {
        utils.launchScan(context, scan);
      }
    }
  }
}
