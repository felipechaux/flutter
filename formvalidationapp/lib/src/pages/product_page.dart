import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidationapp/src/bloc/provider.dart';
import 'package:formvalidationapp/src/models/product_model.dart';
import 'package:formvalidationapp/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  //validaciones form key
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //key
  final formKey = GlobalKey<FormState>();

  //key para snackbar
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //provider de servicios
  //final productProvider = new ProductsProvider();

  //bloc
  ProductsBloc productsBloc;
  //uso de modelo
  ProductModel product = new ProductModel();

  //evitar accionar boton guardar a cada rato
  bool _saving = false;

  //foto
  File photo;

  @override
  Widget build(BuildContext context) {
    productsBloc = Provider.producstBloc(context);
    //arguments
    final ProductModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      product = prodData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _selectPhoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _takePhoto,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          //form como html
          child: Form(
              //identificador form
              key: formKey,
              child: Column(
                children: <Widget>[
                  _showPhoto(),
                  _createName(),
                  _createPrice(),
                  _createAvailable(),
                  _saveButton(context)
                ],
              )),
        ),
      ),
    );
  }

  Widget _createName() {
    //textfield propio de form
    return TextFormField(
      initialValue: product.title,
      //capitalizar por oraciones
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Product'),
      //se ejecuta despues de validar campo
      onSaved: (value) => product.title = value,
      //validaciones
      validator: (value) {
        if (value.length < 3) {
          return 'Enter the product name';
        } else {
          return null;
        }
      },
    );
  }

  Widget _createAvailable() {
    return SwitchListTile(
      value: product.available,
      title: Text('Available'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        product.available = value;
      }),
    );
  }

  Widget _createPrice() {
    return TextFormField(
      initialValue: product.value.toString(),
      //punto en teclado
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Price'),
      onSaved: (value) => product.value = double.parse(value),
      //validaciones
      validator: (value) {
        //validar que solo sea numero
        if (utils.isNumeric(value)) {
          //ok
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _saveButton(BuildContext context) {
    return RaisedButton.icon(
      //cambiar forma
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Save'),
      icon: Icon(Icons.save),
      onPressed: (_saving) ? null : _submit,
    );
  }

  void _submit() async {
    //si formulario invalido
    if (!formKey.currentState.validate()) return;
    //fisparar onsave de campos
    formKey.currentState.save();

    setState(() {
      _saving = true;
    });

    if (photo != null) {
      product.photoUrl = await productsBloc.uploadPhoto(photo);
    }

    if (product.id == null) {
      productsBloc.addProduct(product);
    } else {
      productsBloc.editProduct(product);
    }
    /* setState(() {
      _saving = false;
    });*/
    showSnackbar('Saved');
    Navigator.pop(context);
  }

  void showSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _showPhoto() {
    if (product.photoUrl != null) {
      return FadeInImage(
        image: NetworkImage(product.photoUrl),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      //photo si tiene valor, toma el path,-> (pero si eso es nulo muestra no-image)
      //image: AssetImage(photo?.path ?? 'assets/no-image.png'),
      if (photo != null) {
        return Image.file(
          photo,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  _selectPhoto() async {
    _processImage(ImageSource.gallery);
  }

  _takePhoto() async {
    _processImage(ImageSource.camera);
  }

  _processImage(ImageSource origin) async {
    photo = await ImagePicker.pickImage(source: origin);

    if (photo != null) {
      //limpieza
      product.photoUrl = null;
    }
    setState(() {});
  }
}
