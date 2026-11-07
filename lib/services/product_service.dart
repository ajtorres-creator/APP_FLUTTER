import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> getProducts() async {
    final categories = [
      'smartphones',
      'laptops',
      'tablets',
      'mobile-accessories',
    ];

    final responses = await Future.wait(
      categories.map(
        (category) => http
            .get(Uri.parse('$baseUrl/category/$category'))
            .timeout(const Duration(seconds: 15)),
      ),
    );

    final List<Product> products = [];

    for (final response in responses) {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final List<dynamic> productList = data['products'];

        products.addAll(productList.map((json) => Product.fromJson(json)));
      } else {
        throw Exception(
          'Error al cargar productos. Código: ${response.statusCode}',
        );
      }
    }

    return products;
  }
}
