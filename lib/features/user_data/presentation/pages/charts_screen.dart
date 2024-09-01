import 'dart:math';

import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:provider/provider.dart';
import 'package:swan/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../../../../core/app_constatnts/global.dart';
import '../../../../core/styles/theme/change_notifier.dart';
import '../../../../core/widgets/deafault_screen.dart';
import '../../../../core/widgets/wave_widget.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_states.dart';

class ChartsScreen extends StatelessWidget {
  ChartsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return BlocConsumer<UserDataCubit, UserDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultScreen(
          closeAppBar: true,
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: size.height * .18,
                    color: Theme.of(context).primaryColor,
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutQuad,
                    top: keyboardOpen ? -size.height / 3.7 : 0.0,
                    child: WaveWidget(
                      size: size,
                      yOffset: size.height / 8,
                      color: Theme.of(context).scaffoldBackgroundColor,
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
                            color: Global.whiteColor,
                            fontSize: 28.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                                onTap: (){
                                  themeNotifier.toggleTheme();
                                },
                                child: const Icon(Icons.brightness_4_outlined, color: Global.whiteColor,)),
                            SizedBox(width: 12.w,),
                            const Icon(Icons.language, color: Global.whiteColor,)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                  child: SfCartesianChart(
                    title: ChartTitle(
                      text: 'Money charging',
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 12.sp
                      ),
                      alignment: ChartAlignment.center
                    ),
                    plotAreaBorderWidth: 0,
                    primaryXAxis: CategoryAxis(
                      axisLine: const AxisLine(width: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                      labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 12.sp
                      ),
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: UserDataCubit.instance.maxNumber(),
                      interval: UserDataCubit.instance.maxNumber() / 2,
                      axisLine: const AxisLine(width: 0),
                      labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 12.sp
                      ),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ColumnSeries<SalesData, String>>[
                      ColumnSeries<SalesData, String>(
                        dataSource: data,
                        pointColorMapper: (SalesData data, _) => data.color,
                        animationDuration: 2000,
                        xValueMapper: (SalesData data, _) => data.day,
                        yValueMapper: (SalesData data, _) => data.money,
                      )
                    ]
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<SalesData> data = UserDataCubit.instance.charging.map((e) => SalesData(
    e.createdAt.toString().substring(14,19),
    e.money!.toDouble(),
    color : e.money == UserDataCubit.instance.maxNumber() ? Global.buttonColor : Global.minChartColorDark,
  )).toList();
}


// Padding(
//   padding:  EdgeInsetsDirectional.symmetric(horizontal: 20.w),
//   child: AspectRatio(
//     aspectRatio: 16 / 9,
//     child: DChartBarO(
//       groupList: [
//         OrdinalGroup(
//           id: '1',
//           color: Global.mediumBlue,
//           chartType: ChartType.line,
//           // data: UserDataCubit.instance.charging.map((e) => OrdinalData(domain: DateFormat('MMMM d, y').format(DateTime.parse(e.createdAt.toString())), measure: e.money!.toInt())).toList()
//           data: UserDataCubit.instance.charging.map((e) => OrdinalData(domain: e.createdAt, measure: e.money!.toInt())).toList()
//         ),
//       ],
//     ),
//   ),
// ),