import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:swan/core/app_constatnts/enum_constants.dart';
import 'package:swan/features/user_data/presentation/cubit/user_states.dart';
import 'package:swan/features/user_data/presentation/pages/charts_screen.dart';
import 'package:swan/features/user_data/presentation/pages/user_data_screen.dart';
import 'core/app_constatnts/bloc_observer.dart';
import 'core/app_constatnts/home_model.dart';
import 'core/app_constatnts/routes.dart';
import 'core/network/cache_helper.dart';
import 'core/network/dio_helper.dart';
import 'core/styles/theme/change_notifier.dart';
import 'core/styles/theme/dark_theme.dart';
import 'core/styles/theme/light_theme.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/user_data/presentation/cubit/user_cubit.dart';
import 'locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  CacheHelper.saveData(key: Constants.darkMode.toString(), value: false);
  di.setup();
  Bloc.observer = MyBlocObserver();
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),
    child: const MyApp())
  );
}

final navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackBarKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => di.locator<AuthCubit>()),
        BlocProvider<UserDataCubit>(create: (context) => di.locator<UserDataCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size (360,690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child){
          return ChangeNotifierProvider(
            create: (context) => HomeModel(),
            child : MaterialApp(
              navigatorKey: navigatorKey,
              scaffoldMessengerKey: snackBarKey,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: (settings){
                Widget? wid;
                switch (settings.name) {
                  case Routes.login:
                    wid = const LoginScreen();
                    break;
                  case Routes.userDataScreen:
                    wid = const UserDataScreen();
                    break;
                  case Routes.chartsScreen:
                    wid = ChartsScreen();
                    break;
                }
                if (wid != null) {
                  return PageRouteBuilder(
                      settings: settings,
                      // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
                      pageBuilder: (_, __, ___) => wid!,
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c));
                }
                return null;
              },
              navigatorObservers: [RouteObserver<PageRoute>()],
              // initialRoute: CacheHelper.getData(key: Constants.token.toString()) != null ? Routes.userDataScreen : Routes.login,
              initialRoute: Routes.login,
              theme: light,
              darkTheme: dark,
              themeMode: themeNotifier.currentTheme,
            ),
          );
        },
      ),
    );
  }
}
