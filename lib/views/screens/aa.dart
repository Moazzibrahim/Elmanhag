import 'package:flutter/material.dart';
import 'dart:math';

class StepPathPainter extends CustomPainter {
  final List<StepData> steps;

  StepPathPainter(this.steps);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    // Define control points for the quadratic Bezier curve
    Offset p0 = Offset(size.width / 2, 0);
    Offset p1 = Offset(size.width, size.height / 2);
    Offset p2 = Offset(size.width / 2, size.height);

    Offset previousOffset = p0;

    for (int i = 0; i < steps.length; i++) {
      var t = i / (steps.length - 1);
      var offset = calculateQuadraticBezierPoint(t, p0, p1, p2);

      // Draw dashed line to previous step if it exists
      if (i > 0) {
        drawDashedLine(canvas, paint, previousOffset, offset);
      }

      // Draw circle
      paint.color = steps[i].isLocked ? Colors.grey : Colors.red;
      canvas.drawCircle(offset, 20, paint);

      // Draw step number or lock icon
      var textPainter = TextPainter(
        text: TextSpan(
          text: steps[i].isLocked ? '🔒' : steps[i].number.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas,
          offset - Offset(textPainter.width / 2, textPainter.height / 2));

      // Draw step label
      textPainter = TextPainter(
        text: TextSpan(
          text: steps[i].label,
          style: TextStyle(
            color: steps[i].isLocked ? Colors.grey : Colors.red,
            fontSize: 16,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, offset + Offset(-textPainter.width / 2, 30));

      previousOffset = offset;
    }
  }

  Offset calculateQuadraticBezierPoint(
      double t, Offset p0, Offset p1, Offset p2) {
    double x =
        pow(1 - t, 2) * p0.dx + 2 * (1 - t) * t * p1.dx + pow(t, 2) * p2.dx;
    double y =
        pow(1 - t, 2) * p0.dy + 2 * (1 - t) * t * p1.dy + pow(t, 2) * p2.dy;
    return Offset(x, y);
  }

  void drawDashedLine(Canvas canvas, Paint paint, Offset start, Offset end) {
    const double dashWidth = 5;
    const double dashSpace = 3;
    double distance = (start - end).distance;
    double dx = (end.dx - start.dx) / distance;
    double dy = (end.dy - start.dy) / distance;

    double startX = start.dx;
    double startY = start.dy;
    bool draw = true;

    while (distance >= 0) {
      double endX = startX + (dx * dashWidth);
      double endY = startY + (dy * dashWidth);

      if (draw) {
        canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
      }

      startX = endX + (dx * dashSpace);
      startY = endY + (dy * dashSpace);

      distance -= (dashWidth + dashSpace);
      draw = !draw;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class StepData {
  final int number;
  final String label;
  final bool isLocked;

  StepData(this.number, this.label, this.isLocked);
}

class StepPath extends StatelessWidget {
  final List<StepData> steps = [
    StepData(1, 'هيا نتعلم يا جدي', false),
    StepData(2, 'حرف الألف', false),
    StepData(3, 'حرف الميم', false),
    StepData(4, 'حرف الباء', true),
    StepData(5, 'أنا مميز', true),
  ];

  StepPath({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7CACD),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Define the action for the back button here
          },
        ),
        title: const Text(
          'هيا ابدأ الوحده الثانية',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFE7CACD),
        child: Center(
          child: CustomPaint(
            size: const Size(300, 500),
            painter: StepPathPainter(steps),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: StepPath(),
  ));
}
