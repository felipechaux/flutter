import 'package:latlong/latlong.dart';

class ScanModel {
  ScanModel({
    this.id,
    this.type,
    this.value,
  }) {
    if (this.value.contains('http')) {
      this.type = 'http';
    } else {
      this.type = 'geo';
    }
  }

  int id;
  String type;
  String value;

  //factory nueva instancia
  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  //retornar objeto del mismo tipo - map
  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
      };

  LatLng getLatLng() {
    final coordenates = value.substring(4).split(',');
    final latitude = double.parse(coordenates[0]);
    final longitude = double.parse(coordenates[1]);

    return LatLng(latitude, longitude);
  }
}
