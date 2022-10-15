import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:formvalidation/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String _baseUrl =
      "flutter-varios-f9c6f-default-rtdb.europe-west1.firebasedatabase.app";

  bool isLoading = true;
  final List<Product> products = [];

  //nos permite seleccionar un producto entre páginas
  late Product selectedProduct;

  //hacer peticion de productos

  ProductService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return products;
  }
}
