import 'package:canasta/canasta_text.dart';
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
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: preferedColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: preferedTextColor, width: 2),
            ), //ToDo: with Container around chart or without?
            child: LineChart(
              // duration: const Duration(milliseconds: 100),
              LineChartData(
                backgroundColor: Colors.transparent,
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
                borderData: FlBorderData(
                    show: true, border: Border.all(color: preferedTextColor)),
                lineBarsData: [
                  roundLine(team1, team1Color),
                  roundLine(team2, team2Color)
                ],
                titlesData: FlTitlesData(
                    show: true,
                    topTitles: AxisTitles(sideTitles: SideTitles(
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                            axisSide: AxisSide.top,
                            child: CanastaText(value.toString()));
                      },
                    )),
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 25,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                            axisSide: AxisSide.bottom,
                            child: CanastaText(
                              value.toStringAsFixed(0),
                              size: 14,
                            ));
                      },
                    )),
                    leftTitles: const AxisTitles(sideTitles: SideTitles()),
                    rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 38,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                            axisSide: AxisSide.right,
                            child: CanastaText(
                              "${(value / 1000).toStringAsFixed(0)}K",
                              size: 14,
                            ));
                      },
                    ))), //Done: why is custom color for text not working?
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
