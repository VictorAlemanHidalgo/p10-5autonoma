import 'package:flutter/material.dart';

void main() => runApp(const MiContenedorApp());

class DottedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  DottedBorderPainter({
    this.strokeWidth = 4.0,
    this.dashWidth = 8.0,
    this.dashSpace = 4.0,
    this.borderRadius = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rect);

    final dashPath = Path();
    final pathMetrics = path.computeMetrics();

    for (final metric in pathMetrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        dashPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MiContenedorApp extends StatelessWidget {
  const MiContenedorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Alemán Autonomo"),
          centerTitle: true,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
          backgroundColor: const Color(0xff0066ff),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Victor Aleman Hidalgo. Mat: 22308051281123',
                style: TextStyle(
                    fontSize: 16,
                    fontStyle:
                        FontStyle.italic, // Ajusta el estilo del subtítulo
                    color: Colors.grey[600]),
              ),
              // Contenedor cuadrado con marco lineal y esquinas redondeadas
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Contenedor rectangular con esquinas redondeadas y marco punteado
              Container(
                width: 200,
                height: 100,
                child: CustomPaint(
                  painter: DottedBorderPainter(
                    strokeWidth: 4.0,
                    dashWidth: 8.0,
                    dashSpace: 4.0,
                    borderRadius: 15.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Contenedor circular con marco punteado
              Container(
                width: 100,
                height: 100,
                child: CustomPaint(
                  painter: DottedBorderPainter(
                    strokeWidth: 4.0,
                    dashWidth: 8.0,
                    dashSpace: 4.0,
                    borderRadius: 50.0,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Imagen circular del logo de Flutter con marco punteado
              Container(
                width: 100,
                height: 100,
                child: CustomPaint(
                  painter: DottedBorderPainter(
                    strokeWidth: 4.0,
                    dashWidth: 8.0,
                    dashSpace: 4.0,
                    borderRadius: 50.0,
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://raw.githubusercontent.com/VictorAlemanHidalgo/Imagenes-para-app-flutter-6J/refs/heads/main/flutter.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
