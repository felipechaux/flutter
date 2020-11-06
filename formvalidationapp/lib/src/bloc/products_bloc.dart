import 'dart:io';

import 'package:formvalidationapp/src/providers/products_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:formvalidationapp/src/models/product_model.dart';

class ProductsBloc {
  final _productsController = new BehaviorSubject<List<ProductModel>>();

  final _loadingController = new BehaviorSubject<bool>();

  final _productsProvider = new ProductsProvider();

  //escuchar producto
  Stream<List<ProductModel>> get productsStream => _productsController.stream;

  Stream<bool> get loading => _loadingController.stream;

  void loadProducts() async {
    final products = await _productsProvider.loadProducts();
    _productsController.sink.add(products);
  }

  void addProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    await _productsProvider.createProduct(product);
    _loadingController.sink.add(false);
    loadProducts();
  }

  Future<String> uploadPhoto(File photo) async {
    _loadingController.sink.add(true);
    final photoUtl = await _productsProvider.uploadImage(photo);
    _loadingController.sink.add(false);
    return photoUtl;
  }

  void editProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    await _productsProvider.editProduct(product);
    _loadingController.sink.add(false);
    loadProducts();
  }

  void deleteProduct(String id) async {
    await _productsProvider.deleteProduct(id);
  }

  dispose() {
    _productsController?.close();
    _loadingController?.close();
  }
}
