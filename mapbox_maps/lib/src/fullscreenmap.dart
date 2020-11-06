import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;
  final center = LatLng(37.772645, -122.425069);
  final darkStyle = 'mapbox://styles/felipechauxx/ckf4mdc2d1sa119o8liv7y4cw';
  final celesteStyle = 'mapbox://styles/felipechauxx/ckf4maj431dzf19mt1g5d2wxp';
  String selectedStyle =
      'mapbox://styles/felipechauxx/ckf4mdc2d1sa119o8liv7y4cw';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom.png");
    addImageFromUrl("networkImage",
        "https://avatars0.githubusercontent.com/u/600935?s=200&v=4");
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  Future<void> addImageFromUrl(String name, String url) async {
    var response = await http.get(url);
    return mapController.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: createMap(),
      floatingActionButton: _floatBottons(),
    );
  }

  Column _floatBottons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        //simbolos
        FloatingActionButton(
          child: Icon(Icons.sentiment_very_dissatisfied),
          onPressed: () {
            mapController.addSymbol(SymbolOptions(
                //latitud y longitud
                geometry: center,
                textColor: '#bbbbbb',
                // iconImage: 'attraction-15',
                //iconImage: 'assetImage',
                iconImage: 'networkImage',
                textField: 'Montaña creada',
                textOffset: Offset(0, 1)));
          },
        ),

        //Zoomin
        FloatingActionButton(
          child: Icon(Icons.zoom_in),
          onPressed: () {
            mapController.animateCamera(
                //estilo waze
                //CameraUpdate.tiltTo(40),
                CameraUpdate.zoomIn());
          },
        ),
        SizedBox(height: 5),
        //zoomout
        FloatingActionButton(
          child: Icon(Icons.zoom_out),
          onPressed: () {
            mapController.animateCamera(CameraUpdate.zoomOut());
          },
        ),
        SizedBox(height: 5),

        FloatingActionButton(
            child: Icon(Icons.add_to_home_screen),
            onPressed: () {
              setState(() {
                if (selectedStyle == darkStyle) {
                  selectedStyle = celesteStyle;
                } else {
                  selectedStyle = darkStyle;
                }
                _onStyleLoaded();
              });
            })
      ],
    );
  }

  MapboxMap createMap() {
    return MapboxMap(
      styleString: selectedStyle,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(zoom: 40, target: center),
    );
  }
}
