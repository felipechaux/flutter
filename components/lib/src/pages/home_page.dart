import 'package:flutter/material.dart';
import 'package:components/src/providers/menu_provider.dart';
import 'package:components/src/utils/icono_string_util.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    /*si tarda mucho se bloquea app
    menuProvider.cargarData().then((opciones) {
      print('_lista');
      print(opciones);
    });*/

    return FutureBuilder(
      future: menuProvider.cargarData(),
      //initialData[] la primera vez se envia a snapshot.data
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        print(snapshot.data);
        return ListView(
          children: _listaItems(snapshot.data, context),
        );
      },
    );

    /* return ListView(
      children: _listaItems(),
    );*/
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          /* navegacion normal a una pagina
          final route = MaterialPageRoute(builder: (context) => AlertPage());
          Navigator.push(context, route);*/

          Navigator.pushNamed(context, opt['ruta']);
        },
      );

      opciones..add(widgetTemp)..add(Divider());
    });

    return opciones;
  }
}
