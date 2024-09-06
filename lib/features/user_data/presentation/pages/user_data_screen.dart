import 'package:easy_localization/easy_localization.dart';
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
import 'package:swan/core/widgets/network_faild.dart';
import 'package:swan/features/user_data/presentation/pages/widgets/item_card.dart';
import 'package:swan/features/user_data/presentation/pages/widgets/user_data_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/app_constatnts/app_localization.dart';
import '../../../../core/app_constatnts/home_model.dart';
import '../../../../core/styles/theme/change_notifier.dart';
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

  bool isTap = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await UserDataCubit.instance.getUserData();
    await UserDataCubit.instance.getSettings();
  }

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
                        Text(
                          AppLocalizations.of(context)!.translate('home'),
                          style: const TextStyle(
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
                            InkWell(
                              onTap: (){
                                Locale myLocale = Localizations.localeOf(context);
                                setState(() {
                                  myLocale = context.locale;
                                  if (myLocale.languageCode == 'en') {
                                    isTap = true;
                                    Future.delayed(const Duration(seconds: 2), () {
                                      setState(() {
                                        isTap = false;
                                      });
                                    });
                                    context.locale = const Locale('ar');
                                  } else {
                                    isTap = true;
                                    Future.delayed(const Duration(seconds: 2), () {
                                      setState(() {
                                        isTap = false;
                                      });
                                    });
                                    context.locale = const Locale('en');
                                  }
                                });
                              },
                              child: const Icon(Icons.language, color: Global.whiteColor,))
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
                    state is GetSettingsLoading || state is GetUserDataLoading ? const Center(child: CircularProgressIndicator(),)
                        : state is GetSettingsFailure || state is GetSettingsError || state is GetUserDataError || state is GetUserDataFailure
                    ? const NetworkFailedScreen() : getNetworkFailed(state)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        title: AppLocalizations.of(context)!.translate('faceBook'),
                        pathImage: "assets/images/signin_facebook.svg",
                        onTap: (){
                          launchURL(UserDataCubit.instance.settingsEntity!.facebook!);
                          // launchURL(UserDataCubit.instance.settingsEntity!.facebook!);
                        },
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    Expanded(
                      child:  ButtonWidget(
                        title: AppLocalizations.of(context)!.translate('instagram'),
                        pathImage: "assets/images/insta.svg",
                        onTap: (){
                          launchURL(UserDataCubit.instance.settingsEntity!.instagram!);
                        },
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    Expanded(
                      child: ButtonWidget(
                        title: AppLocalizations.of(context)!.translate('whats'),
                        pathImage: "assets/images/whats.svg",
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
////////////////////////////////////////////////////////////////////////////////
  void launchURL(String urlPath) async {
    try{
      if (await canLaunchUrl(Uri.parse(urlPath))) {
        await launchUrl(Uri.parse(urlPath));
      }
    }catch(e){
      debugPrint("error is $e");
    }
  }
////////////////////////////////////////////////////////////////////////////////
  getNetworkFailed(UserDataStates state){
    return Expanded(
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
                  labelText: AppLocalizations.of(context)!.translate('user'),
                  labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 18.sp
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: .5.w, color: Colors.grey,),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Column(
                  children: [
                    ItemForCard(
                      text: AppLocalizations.of(context)!.translate('name'),
                      titleData: UserDataCubit.instance.userDataEntity?.userName ?? "",
                      leadingIcon: Icons.person,
                      textStyle: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 10.h,),
                    ItemForCard(
                      text: AppLocalizations.of(context)!.translate('email'),
                      titleData: UserDataCubit.instance.userDataEntity?.email ?? "",
                      leadingIcon: Icons.email,
                    ),
                    SizedBox(height: 10.h,),
                    ItemForCard(
                      text: AppLocalizations.of(context)!.translate('limit'),
                      titleData: UserDataCubit.instance.userDataEntity?.limit != null ? UserDataCubit.instance.userDataEntity?.limit.toString() : "",
                      leadingIcon: Icons.gas_meter_outlined,
                    ),
                    SizedBox(height: 10.h,),
                    ItemForCard(
                      text: AppLocalizations.of(context)!.translate('mobile'),
                      titleData: UserDataCubit.instance.userDataEntity?.mobile != null ? UserDataCubit.instance.userDataEntity?.mobile.toString() : "",
                      leadingIcon: Icons.call,
                    ),
                    SizedBox(height: 10.h,),
                    ItemForCard(
                      text: AppLocalizations.of(context)!.translate('room'),
                      titleData: UserDataCubit.instance.userDataEntity?.roomNumber != null ? UserDataCubit.instance.userDataEntity?.roomNumber.toString() : "",
                      leadingIcon: Icons.home_filled,
                    ),
                    SizedBox(height: 10.h,),
                    ItemForCard(
                      text: AppLocalizations.of(context)!.translate('status'),
                      titleData: getStatus(),
                      leadingIcon: Icons.report_gmailerrorred_rounded,
                      valueColor: UserDataCubit.instance.userDataEntity?.status != null ? UserDataCubit.instance.userDataEntity?.status == true ? Colors.green : Colors.red : Global.greyColor,
                    ),
                    SizedBox(height: 10.h,),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ItemForCard(
                        text: AppLocalizations.of(context)!.translate('tax'),
                        titleData: UserDataCubit.instance.userDataEntity?.tax?[index].value != null ? UserDataCubit.instance.userDataEntity!.tax![index].value.toString() : "",
                        leadingIcon: Icons.gas_meter_outlined,
                      ),
                      itemCount: UserDataCubit.instance.tax.length,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h,),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.translate('flowRate'),
                  labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 18.sp
                  ),
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
                          style: GaugeAxisStyle(
                            thickness: 12,
                            background: Theme.of(context).primaryColor,
                            segmentSpacing: 4,
                          ),
                          pointer: GaugePointer.needle(
                            width: 20,
                            height: 60,
                            color: Theme.of(context).indicatorColor,
                          ),
                          progressBar: GaugeProgressBar.rounded(
                            color: Theme.of(context).primaryColor,
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
                  labelText: AppLocalizations.of(context)!.translate('consumption'),
                  labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 18.sp
                  ),
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
                      selectedColor: Theme.of(context).primaryColor,
                      unselectedColor: Theme.of(context).disabledColor,
                      padding: 0,
                      width: 140.h,
                      height: 140.h,
                      selectedStepSize: 12,
                      // roundedCap: (_, __) => true,
                      child: Center(
                        child: Text(
                            "% ${UserDataCubit.instance.userDataEntity?.consumption ?? 0}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w800,
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h,),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.translate('totalMeters'),
                  labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 18.sp
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: .5.w, color: Colors.grey,),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularStepProgressIndicator(
                      totalSteps: 100,
                      currentStep: UserDataCubit.instance.userDataEntity?.limit ?? 0,
                      stepSize: 12,
                      selectedColor: Theme.of(context).primaryColor,
                      unselectedColor: Theme.of(context).disabledColor,
                      padding: 0,
                      width: 140.h,
                      height: 140.h,
                      selectedStepSize: 12,
                      // roundedCap: (_, __) => true,
                      child: Center(
                        child: Text(
                          "% ${UserDataCubit.instance.userDataEntity?.limit ?? 0}",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w800,
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 18.h,),
              // ButtonWidget(
              //   title: AppLocalizations.of(context)!.translate('charts'),
              //   onTap: (){
              //     navigateToNamed(route: Routes.chartsScreen);
              //   },
              // ),
              SizedBox(height: 12.h,),
            ],
          ),
        ),
      ),
    );
  }
////////////////////////////////////////////////////////////////////////////////
  getStatus(){
    if(UserDataCubit.instance.userDataEntity?.status != null){
      if(UserDataCubit.instance.userDataEntity?.status == true){
        return AppLocalizations.of(context)!.translate('on');
      }else{
        return AppLocalizations.of(context)!.translate('off');
      }
    }
  }
////////////////////////////////////////////////////////////////////////////////
}
