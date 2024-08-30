import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../../../../core/app_constatnts/global.dart';
import '../../../../core/widgets/deafault_screen.dart';
import '../../../../core/widgets/wave_widget.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return DefaultScreen(
      closeAppBar: true,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * .18,
                color: Global.mediumBlue,
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutQuad,
                top: keyboardOpen ? -size.height / 3.7 : 0.0,
                child: WaveWidget(
                  size: size,
                  yOffset: size.height / 8,
                  color: Global.white,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 24.h, start: 20.w, end: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Charts',
                      style: TextStyle(
                        color: Global.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.brightness_4_outlined, color: Colors.white,),
                        SizedBox(width: 12.w,),
                        const Icon(Icons.language, color: Colors.white,)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          // SfCartesianChart(
          //     title: const ChartTitle(
          //         text: '74 Sales Invoice',
          //         backgroundColor: Colors.white,
          //         textStyle: TextStyle(fontSize: 12),
          //         alignment: ChartAlignment.center),
          //     plotAreaBorderWidth: 0,
          //     primaryXAxis: const CategoryAxis(
          //       axisLine: AxisLine(width: 0),
          //       majorGridLines: MajorGridLines(width: 0),
          //     ),
          //     primaryYAxis: const NumericAxis(
          //       minimum: 0,
          //       maximum: 500,
          //       interval: 250,
          //       axisLine: AxisLine(width: 0),
          //       majorGridLines: MajorGridLines(width: 0),
          //     ),
          //     tooltipBehavior: TooltipBehavior(enable: true),
          //     series: <ColumnSeries<SalesData, String>>[
          //       ColumnSeries<SalesData, String>(
          //         dataSource: data,
          //         pointColorMapper: (SalesData data, _) => data.color,
          //         animationDuration: 2000,
          //         xValueMapper: (SalesData data, _) => data.day,
          //         yValueMapper: (SalesData data, _) => data.rate,
          //       )
          //     ]),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.day, this.rate, {this.color});
  final String day;
  final double rate;
  final Color? color;
}
List<SalesData> data = [
  SalesData('M', 100,color: Colors.grey.shade400),  //  color: Colors.grey.shade400
  SalesData('T', 270,color: Colors.grey.shade400),
  SalesData('W', 480, color: Colors.red.shade300),
  SalesData('T ', 150, color: Colors.grey.shade400),
  SalesData('F', 350, color: Colors.grey.shade400),
  SalesData('S', 250, color: Colors.grey.shade400),
  SalesData('S ', 150, color: Colors.grey.shade400),
];