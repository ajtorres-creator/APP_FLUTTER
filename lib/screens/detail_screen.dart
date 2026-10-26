import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String price;

  const DetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del producto'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.shopping_bag, size: 90, color: Colors.blue),
            ),

            const SizedBox(height: 20),

            Text(
              widget.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Text(widget.description, style: const TextStyle(fontSize: 17)),

            const SizedBox(height: 12),

            Text(
              'Precio: ${widget.price}',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.verified_user, color: Colors.green, size: 32),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Producto disponible para consulta.',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              '¿Tienes alguna consulta?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Escribe tu consulta',
                hintText: 'Ej.: ¿El producto tiene garantía?',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),
              ),
              maxLines: 3,
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  final consulta = _controller.text.trim();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        consulta.isEmpty
                            ? 'Escribe una consulta primero.'
                            : 'Consulta registrada: $consulta',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.send),
                label: const Text('Enviar consulta'),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver al catálogo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
