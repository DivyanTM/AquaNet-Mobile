import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final List<FlSpot> dataPoints;

  const LineChartWidget({super.key, required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    final safePoints = dataPoints
        .where((p) => p.x.isFinite && !p.x.isNaN && p.y.isFinite && !p.y.isNaN)
        .toList();

    if (safePoints.isEmpty) {
      return const Center(
        child: Text('No valid data', style: TextStyle(color: Colors.red)),
      );
    }

    double minX = safePoints.map((e) => e.x).reduce((a, b) => a < b ? a : b);
    double maxX = safePoints.map((e) => e.x).reduce((a, b) => a > b ? a : b);
    double minY = safePoints.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    double maxY = safePoints.map((e) => e.y).reduce((a, b) => a > b ? a : b);

    double rangeX = (maxX - minX).abs();
    double rangeY = (maxY - minY).abs();
    if (rangeX == 0) rangeX = 1;
    if (rangeY == 0) rangeY = 1;

    minX -= rangeX * 0.1;
    maxX += rangeX * 0.1;
    minY -= rangeY * 0.2;
    maxY += rangeY * 0.2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LineChart(
        LineChartData(
          minX: minX,
          maxX: maxX,
          minY: minY,
          maxY: maxY,
          backgroundColor: Colors.transparent,
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(1),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: Colors.grey.withOpacity(0.1), strokeWidth: 1),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: safePoints,
              isCurved: true,
              barWidth: 4,
              isStrokeCapRound: true,
              color: Colors.blueAccent,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blueAccent.withOpacity(0.3),
                    Colors.blueAccent.withOpacity(0.05),
                  ],
                ),
              ),
              dotData: FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}
