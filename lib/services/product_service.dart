import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductService {
  static const String apiUrl = 'https://dummyjson.com/products';

  Future<List<Product>> getProducts() async {
    final response = await http
        .get(Uri.parse(apiUrl))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      final List<dynamic> productList = data['products'];

      return productList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception(
        'Error al cargar productos. Código: ${response.statusCode}',
      );
    }
  }
}
