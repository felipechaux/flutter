import 'package:flutter/material.dart';
import 'package:formvalidationapp/src/bloc/provider.dart';
import 'package:formvalidationapp/src/models/product_model.dart';

class HomePage extends StatelessWidget {
  //final productsProvider = new ProductsProvider();

  @override
  Widget build(BuildContext context) {
    final productsBloc = Provider.producstBloc(context);
    productsBloc.loadProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _createListProducts(productsBloc),
      floatingActionButton: _createButton(context),
    );
  }
}

Widget _createListProducts(ProductsBloc productsBloc) {
  return StreamBuilder(
    stream: productsBloc.productsStream,
    builder:
        (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
      if (snapshot.hasData) {
        final products = snapshot.data;
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, i) =>
              _createItemProduct(context, productsBloc, products[i]),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

Widget _createItemProduct(
    BuildContext context, ProductsBloc productsBloc, ProductModel product) {
  return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        //delete product
        //  productsProvider.deleteProduct(product.id);
        productsBloc.deleteProduct(product.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (product.photoUrl == null)
                ? Image(
                    image: AssetImage('assets/no-image.png'),
                  )
                : FadeInImage(
                    image: NetworkImage(product.photoUrl),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover),
            ListTile(
                title: Text('${product.title} - ${product.value}'),
                subtitle: Text(product.id),
                onTap: () =>
                    Navigator.pushNamed(context, 'product', arguments: product))
          ],
        ),
      ));
}

_createButton(BuildContext context) {
  return FloatingActionButton(
    child: Icon(Icons.add),
    backgroundColor: Colors.deepPurple,
    onPressed: () => Navigator.pushNamed(context, 'product'),
  );
}
