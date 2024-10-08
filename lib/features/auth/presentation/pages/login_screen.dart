import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:swan/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:swan/features/auth/presentation/cubit/auth_states.dart';
import '../../../../core/app_constatnts/global.dart';
import '../../../../core/app_constatnts/home_model.dart';
import '../../../../core/app_constatnts/navigate_methods.dart';
import '../../../../core/widgets/button_widget.dart';
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
    final model = Provider.of<HomeModel>(context);

    return BlocConsumer <AuthCubit, AuthStates> (
      listener: (context, state){
        if(state is LoginSuccess){
          customShowSnackBar(isError: false, message: "Login Successfully");
          emailController.clear();
          passwordController.clear();
        } else if (state is LoginError){
          emailController.clear();
          passwordController.clear();
          customShowSnackBar(isError: true, message: "Login Error");
        }
      },
      builder: (context, state) => Scaffold(
      backgroundColor: Global.white,
      appBar: PreferredSize(
          preferredSize: Size.zero,
          child: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarColor: Global.mediumBlue,
            ),
          )
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height - 200,
            color: Global.mediumBlue,
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 3.5,
              color: Global.white,
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
                    color: Global.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 30.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 24,),
                  CustomTextFormField(
                    controller: emailController,

                    onChange: (value) {
                      model.isValidEmail(value);
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "required";
                      }
                      return null;
                    },
                    label: 'Email',
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CustomTextFormField(
                    label: 'Password',
                    isPasswordVisible: true,
                    controller: passwordController,
                    // obscureText: model.isVisible ? false : true,
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
                      hasBorder: false,
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
