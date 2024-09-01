import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:swan/core/app_constatnts/routes.dart';
import 'package:swan/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:swan/features/auth/presentation/cubit/auth_states.dart';
import 'package:swan/features/user_data/presentation/pages/user_data_screen.dart';
import '../../../../core/app_constatnts/global.dart';
import '../../../../core/app_constatnts/home_model.dart';
import '../../../../core/app_constatnts/navigate_methods.dart';
import '../../../../core/styles/theme/change_notifier.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/deafault_screen.dart';
import '../../../../core/widgets/textfield_widget.dart';
import '../../../../core/widgets/wave_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var formKey = GlobalKey <FormState> ();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return BlocConsumer <AuthCubit, AuthStates> (
      listener: (context, state){
        if(state is LoginSuccess){
          customShowSnackBar(isError: false, message: "Login Successfully");
          emailController.clear();
          passwordController.clear();
          navigateToAndRemoveNamed(route: Routes.userDataScreen);
        } else if (state is LoginError){
          emailController.clear();
          passwordController.clear();
          customShowSnackBar(isError: true, message: "Login Error");
        }
      },
      builder: (context, state) => DefaultScreen(
      closeAppBar: true,
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                height: keyboardOpen ? 20.h: size.height * .30,
                color: Theme.of(context).primaryColor,
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutQuad,
                top: keyboardOpen ? - size.height / 3.7 : 0.0,
                // top: 0.0 ,
                child: WaveWidget(
                  size: size,
                  yOffset: keyboardOpen ? 20.h : size.height / 4,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 70.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Global.whiteColor,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 30.h),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30.h,),
                  CustomTextFormField(
                    controller: emailController,
                    prefix: const Icon(Icons.email_outlined, color: Colors.grey,),
                    validator: (value){
                      if(value!.isEmpty){
                        return "required";
                      }
                      return null;
                    },
                    label: 'Email',
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    label: 'Password',
                    isPasswordVisible: AuthCubit.instance.obscureText,
                    controller: passwordController,
                    prefix: const Icon(Icons.lock_outline, color: Colors.grey,),
                    suffix: Padding(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 0.w),
                      child: IconButton(
                        onPressed: (){
                          AuthCubit.instance.changeObscureText();
                        },
                        icon: Icon(AuthCubit.instance.obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        iconSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "required";
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(
                  //   height: 10.0,
                  // ),
                  // const Text(
                  //   'Forgot password?',
                  //   style: TextStyle(
                  //     color: Global.mediumBlue,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ConditionalBuilder(
                      condition: state is !LoginLoading,
                      builder: (context) => ButtonWidget(
                        title: 'Login',
                        onTap: (){
                          if(formKey.currentState!.validate()){
                            AuthCubit.instance.loginMethod(emailController.text, passwordController.text);
                          }
                        },
                      ),
                      fallback: (context) => const Center(child: CircularProgressIndicator(),)
                  ),

                  // const SizedBox(
                  //   height: 10.0,
                  // ),
                  // const ButtonWidget(
                  //   title: 'Sign Up',
                  //   hasBorder: true,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
