import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();

  List<Product> products = [];

  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      products = await _productService.getProducts();
    } catch (e) {
      errorMessage =
          'No se pudieron cargar los productos. Verifica tu conexión.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshProducts() async {
    try {
      final updatedProducts = await _productService.getProducts();
      products = updatedProducts;
      errorMessage = null;
    } catch (e) {
      errorMessage = 'No se pudieron actualizar los productos.';
    }

    notifyListeners();
  }
}
