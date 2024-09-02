import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:swan/core/app_constatnts/enum_constants.dart';
import 'package:swan/core/app_constatnts/global.dart';
import 'package:swan/core/app_constatnts/navigate_methods.dart';
import 'package:swan/core/app_constatnts/routes.dart';
import 'package:swan/core/network/cache_helper.dart';
import 'package:swan/core/widgets/deafault_screen.dart';
import 'package:swan/features/user_data/presentation/pages/widgets/item_card.dart';
import 'package:swan/features/user_data/presentation/pages/widgets/user_data_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/app_constatnts/home_model.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/wave_widget.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_states.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {

  @override
  void initState() {
    UserDataCubit.instance.getUserData();
    UserDataCubit.instance.getSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
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
                    color: Global.mediumBlueLight,
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
                          'Home',
                          style: TextStyle(
                            color: Global.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  if(CacheHelper.getData(key: Constants.darkMode.toString()) == true){
                                    CacheHelper.saveData(key: Constants.darkMode.toString(), value: false);
                                  }else{
                                    CacheHelper.saveData(key: Constants.darkMode.toString(), value: true);
                                  }
                                });
                              },
                              child: Icon(Icons.brightness_4_outlined, color: Theme.of(context).iconTheme.color,)),
                            SizedBox(width: 12.w,),
                            Icon(Icons.language, color: Theme.of(context).iconTheme.color,)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    state is GetUserDataLoading || state is GetSettingsLoading? const Center(child: CircularProgressIndicator(),): Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 12.h,),
                              InputDecorator(
                                decoration: InputDecoration(
                                  labelText: "User",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: .5.w, color: Colors.grey,),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    ItemForCard(
                                      text: 'User Name',
                                      titleData: UserDataCubit.instance.userDataEntity?.userName ?? "",
                                      leadingIcon: Icons.person,
                                      trailingIcon: Icons.arrow_forward_ios_outlined,
                                    ),
                                    SizedBox(height: 10.h,),
                                    ItemForCard(
                                      text: 'Email',
                                      titleData: UserDataCubit.instance.userDataEntity?.email ?? "",
                                      leadingIcon: Icons.email,
                                      trailingIcon: Icons.arrow_forward_ios_outlined,
                                    ),
                                    SizedBox(height: 10.h,),
                                    ItemForCard(
                                      text: 'Limit',
                                      titleData: UserDataCubit.instance.userDataEntity?.limit != null ? UserDataCubit.instance.userDataEntity?.limit.toString() : "",
                                      leadingIcon: Icons.gas_meter_outlined,
                                      trailingIcon: Icons.arrow_forward_ios_outlined,
                                    ),
                                    SizedBox(height: 10.h,),
                                    ItemForCard(
                                      text: 'Mobile Number',
                                      titleData: UserDataCubit.instance.userDataEntity?.mobile != null ? UserDataCubit.instance.userDataEntity?.mobile.toString() : "",
                                      leadingIcon: Icons.call,
                                      trailingIcon: Icons.arrow_forward_ios_outlined,
                                    ),
                                    SizedBox(height: 10.h,),
                                    ItemForCard(
                                      text: 'Room Number',
                                      titleData: UserDataCubit.instance.userDataEntity?.roomNumber != null ? UserDataCubit.instance.userDataEntity?.roomNumber.toString() : "",
                                      leadingIcon: Icons.home_filled,
                                      trailingIcon: Icons.arrow_forward_ios_outlined,
                                    ),
                                    SizedBox(height: 10.h,),
                                    ItemForCard(
                                      text: 'Status',
                                      titleData: UserDataCubit.instance.userDataEntity?.status != null ? UserDataCubit.instance.userDataEntity?.status?.toString() : "",
                                      leadingIcon: Icons.report_gmailerrorred_rounded,
                                      trailingIcon: Icons.arrow_forward_ios_outlined,
                                    ),
                                    SizedBox(height: 10.h,),
                                    ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => ItemForCard(
                                        text: 'Tax',
                                        titleData: UserDataCubit.instance.userDataEntity?.tax?[index].value != null ? UserDataCubit.instance.userDataEntity!.tax![index].value.toString() : "",
                                        leadingIcon: Icons.gas_meter_outlined,
                                        trailingIcon: Icons.arrow_forward_ios_outlined,
                                      ),
                                      itemCount: UserDataCubit.instance.tax.length,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 18.h,),
                              InputDecorator(
                                decoration: InputDecoration(
                                  labelText: "Flow Rate",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: .5.w, color: Colors.grey,),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimatedRadialGauge(
                                      duration: const Duration(seconds: 1),
                                      value: UserDataCubit.instance.userDataEntity?.flowRate?.toDouble() ??.5,
                                      // value:  0,
                                      curve: Curves.elasticOut,
                                      radius: 80,
                                      axis: GaugeAxis(
                                          min: 0,
                                          max: 1000,
                                          style: const GaugeAxisStyle(
                                            thickness: 12,
                                            background: Global.mediumBlueLight,
                                            segmentSpacing: 4,
                                          ),
                                          pointer: GaugePointer.needle(
                                              width: 20,
                                              height: 60,
                                              color: Colors.black.withOpacity(.90)
                                          ),
                                          progressBar: const GaugeProgressBar.rounded(
                                            color: Global.mediumBlueLight,
                                          ),
                                          segments: const [
                                            GaugeSegment(
                                              from: 0,
                                              to: 250,
                                              color: Color(0xFFD9DEEB),
                                              cornerRadius: Radius.zero,
                                            ),
                                            GaugeSegment(
                                              from: 250,
                                              to: 500,
                                              color: Color(0xFFD9DEEB),
                                              cornerRadius: Radius.zero,
                                            ),
                                            GaugeSegment(
                                              from: 500,
                                              to: 750,
                                              color: Color(0xFFD9DEEB),
                                              cornerRadius: Radius.zero,
                                            ),
                                            GaugeSegment(
                                              from: 750,
                                              to: 1000,
                                              color: Color(0xFFD9DEEB),
                                              cornerRadius: Radius.zero,
                                            ),
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24.h,),
                              InputDecorator(
                                decoration: InputDecoration(
                                  labelText: "Consumption",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: .5.w, color: Colors.grey,),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularStepProgressIndicator(
                                      totalSteps: UserDataCubit.instance.userDataEntity?.limit ?? 100,
                                      currentStep: UserDataCubit.instance.userDataEntity?.consumption ?? 0,
                                      stepSize: 12,
                                      selectedColor: Global.mediumBlueLight,
                                      unselectedColor: Colors.blueAccent.withOpacity(.2),
                                      padding: 0,
                                      width: 140.h,
                                      height: 140.h,
                                      selectedStepSize: 12,
                                      // roundedCap: (_, __) => true,
                                      child: Center(
                                        child: Text(
                                          "% ${UserDataCubit.instance.userDataEntity?.consumption ?? 0}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontFamily: "DXRound",
                                            fontWeight: FontWeight.w800,
                                            color: Global.mediumBlueLight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 18.h,),
                              ButtonWidget(
                                title: 'Charts',
                                hasBorder: false,
                                onTap: (){
                                  navigateToNamed(route: Routes.chartsScreen);
                                },
                              ),
                              SizedBox(height: 12.h,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        title: 'Face',
                        pathImage: "assets/images/signin_facebook.svg",
                        hasBorder: true,
                        onTap: (){
                          launchURL(UserDataCubit.instance.settingsEntity!.facebook!);
                        },
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    Expanded(
                      child:  ButtonWidget(
                        title: 'Insta',
                        pathImage: "assets/images/insta.svg",
                        hasBorder: true,
                        onTap: (){
                          launchURL(UserDataCubit.instance.settingsEntity!.instagram!);
                        },
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    Expanded(
                      child: ButtonWidget(
                        title: 'Whats',
                        pathImage: "assets/images/whats.svg",
                        hasBorder: true,
                        onTap: (){
                          launchURL(UserDataCubit.instance.settingsEntity!.whatsAppLink!);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        );
      },
    );
  }

  void launchURL(String urlPath) async {
    if (await canLaunchUrl(Uri.parse(urlPath))) {
      await launchUrl(Uri.parse(urlPath));
    } else {
      throw 'Could not launch $urlPath';
    }
  }
}
