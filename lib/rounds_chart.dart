import 'package:canasta/global.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'team.dart';

class RoundsChart extends StatelessWidget {
  const RoundsChart({required this.team1, required this.team2, super.key});
  final Team team1;
  final Team team2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 15,
        ),
        AspectRatio(
          aspectRatio: 1.5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: LineChart(
              duration: const Duration(milliseconds: 100),
              LineChartData(
                minY: 0,
                maxY: 40000,
                minX: 0,
                // maxX:
                lineTouchData: const LineTouchData(enabled: false),
                clipData: const FlClipData.all(),
                gridData: const FlGridData(
                  show: true,
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  roundLine(team1, team1Color),
                  roundLine(team2, team2Color)
                ],
                titlesData: const FlTitlesData(
                    show: true,
                    topTitles: AxisTitles(sideTitles: SideTitles()),
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true, interval: 1)),
                    leftTitles: AxisTitles(sideTitles: SideTitles()),
                    rightTitles: AxisTitles(
                        sideTitles:
                            SideTitles(showTitles: true, reservedSize: 38))),
              ),
            ),
          ),
        )
      ],
    );
  }

  LineChartBarData roundLine(Team team, Color lineColor) {
    List<FlSpot> points = [];
    points.add(const FlSpot(0, 0));
    for (int i = 0; i < team.roundPoints.length; i++) {
      points.add(FlSpot(
          (i + 1).toDouble(), team.getAccumulatedRoundPoints(i).toDouble()));
    }
    return LineChartBarData(
        spots: points,
        dotData: const FlDotData(
          show: true,
        ),
        // gradient: LinearGradient(
        //   colors: [widget.sinColor.withOpacity(0), widget.sinColor],
        //   stops: const [0.1, 1.0],
        // ),
        color: lineColor,
        barWidth: 4,
        isCurved: false,
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
            colors: [lineColor.withOpacity(0), lineColor.withOpacity(0.5)],
            stops: const [0.1, 1.0],
          ),
        ));
  }
}
