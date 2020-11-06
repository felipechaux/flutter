import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController map = new MapController();

  //convertir de stateless a stateful widget para cambios de valores a mapType
  String mapType = 'streets';

  @override
  Widget build(BuildContext context) {
    //argumentos
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Locations QR'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                map.move(scan.getLatLng(), 15);
              })
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: _createFloatButton(context),
    );
  }

  Widget _createFloatButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        print("accion");

        if (mapType == 'streets') {
          mapType = 'dark';
          setState(() {});
        } else if (mapType == 'dark') {
          mapType = 'light';
        } else if (mapType == 'light') {
          mapType = 'outdoors';
        } else if (mapType == 'outdoors') {
          mapType = 'satellite';
        } else {
          mapType = 'streets';
        }

        setState(() {});
      },
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
          //ubicacion mapa
          center: scan.getLatLng(),
          zoom: 15),
      layers: [_createMap(), _createMarkers(scan)],
    );
  }

  _createMap() {
    //uso de map
    return TileLayerOptions(
        urlTemplate: 'https://api.tiles.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1Ijoiam9yZ2VncmVnb3J5IiwiYSI6ImNrODk5aXE5cjA0c2wzZ3BjcTA0NGs3YjcifQ.H9LcQyP_-G9sxhaT5YbVow',
          'id': 'mapbox.$mapType'
          //streets,dark, light, outdoors, satellite
        });
  }

  _createMarkers(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          //dibujar
          builder: (context) => Container(
                child: Icon(Icons.location_on,
                    size: 70.0, color: Theme.of(context).primaryColor),
              ))
    ]);
  }
}
