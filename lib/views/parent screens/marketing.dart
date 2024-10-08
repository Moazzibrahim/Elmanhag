import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/constants/colors.dart';

class MarketingScreen extends StatelessWidget {
  const MarketingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          child: const Icon(Icons.arrow_back, color: redcolor),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'التسويق بالعمولة',
          style: TextStyle(color: redcolor, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            InfoCard(),
            SizedBox(height: 20),
            ChartCard(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('الإيرادات الكلية', style: TextStyle(fontSize: 16)),
                Text('1000 ج.م',
                    style: TextStyle(fontSize: 16, color: redcolor)),
              ],
            ),
            Column(
              children: [
                Text('عدد التسجيلات', style: TextStyle(fontSize: 16)),
                Text('10', style: TextStyle(fontSize: 16, color: redcolor)),
              ],
            ),
            Column(
              children: [
                Text('الرصيد المتاح', style: TextStyle(fontSize: 16)),
                Text('1000 ج.م',
                    style: TextStyle(fontSize: 16, color: redcolor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChartCard extends StatelessWidget {
  const ChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('تطور الارباح', style: TextStyle(fontSize: 16)),
                Spacer(),
                Text('شهرياً', style: TextStyle(fontSize: 16, color: redcolor)),
                Icon(Icons.arrow_drop_down, color: redcolor),
              ],
            ),
            SizedBox(height: 200, child: ProfitChart()),
          ],
        ),
      ),
    );
  }
}

class ProfitChart extends StatelessWidget {
  const ProfitChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 100),
              const FlSpot(1, 200),
              const FlSpot(2, 300),
              const FlSpot(3, 400),
              const FlSpot(4, 500),
              const FlSpot(5, 600),
            ],
            isCurved: true,
            barWidth: 2,
            color: redcolor,
            dotData: const FlDotData(show: false),
          ),
        ],
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const ActionButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: redcolor,
        iconColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}


