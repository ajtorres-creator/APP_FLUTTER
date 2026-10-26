import 'package:flutter/material.dart';

import '../screens/detail_screen.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final IconData icon;

  const ProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(description),
                  const SizedBox(height: 6),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            title: title,
                            description: description,
                            price: price,
                          ),
                        ),
                      );
                    },
                    child: const Text('Ver detalles'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
