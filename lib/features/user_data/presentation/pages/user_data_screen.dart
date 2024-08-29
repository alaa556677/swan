import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:swan/core/app_constatnts/global.dart';
import 'package:swan/core/widgets/deafault_screen.dart';
import 'package:swan/features/user_data/presentation/pages/widgets/user_data_card.dart';
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
    final model = Provider.of<HomeModel>(context);
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
              state is GetUserDataLoading ? const Center(child: CircularProgressIndicator(),): Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Follow Us",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Expanded(
                              child: ButtonWidget(
                                title: 'Face',
                                pathImage: "assets/images/signin_facebook.svg",
                                hasBorder: true,
                                onTap: (){},
                              ),
                            ),
                            SizedBox(width: 8.w,),
                            Expanded(
                              child:  ButtonWidget(
                                title: 'Insta',
                                pathImage: "assets/images/insta.svg",
                                hasBorder: true,
                                onTap: (){},
                              ),
                            ),
                            SizedBox(width: 8.w,),
                            Expanded(
                              child: ButtonWidget(
                                title: 'Whats',
                                pathImage: "assets/images/whats.svg",
                                hasBorder: true,
                                onTap: (){},
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 12.h,),

                        // ListView.builder(
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   itemBuilder: (context, index) => UserDataCard(
                        //     userDataEntityEntity: UserDataCubit.instance.userDataEntityEntity!,
                        //     tax: UserDataCubit.instance.tax[index],
                        //   ),
                        //   itemCount: UserDataCubit.instance.tax.length,
                        // )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        );
      },
    );
  }
}
