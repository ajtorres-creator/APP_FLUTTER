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

  void _enviarConsulta() {
    final consulta = _controller.text.trim();

    if (consulta.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Escribe una consulta antes de enviarla.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tu consulta ha sido registrada correctamente.'),
      ),
    );

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del producto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 90,
                color: Color(0xFF2563EB),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF101827),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              widget.description,
              style: const TextStyle(fontSize: 16, color: Color(0xFF64748B)),
            ),

            const SizedBox(height: 14),

            Text(
              'Precio: ${widget.price}',
              style: const TextStyle(
                fontSize: 23,
                color: Color(0xFF2563EB),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 22),

            Card(
              color: const Color(0xFFECFDF5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: Color(0xFF059669),
                      size: 32,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Producto disponible para consulta.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF065F46),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              '¿Tienes alguna consulta?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF101827),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Escribe tu consulta',
                hintText: 'Ej.: ¿El producto tiene garantía?',
                prefixIcon: const Icon(Icons.message_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF2563EB),
                    width: 2,
                  ),
                ),
              ),
              maxLines: 3,
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _enviarConsulta,
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
