import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/features/auth/presentation/cubit/user.cubit.dart';
import 'src/features/auth/presentation/pages/app.dart';
import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'src/core/localization/app_localization.dart';
import 'src/core/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'src/core/services/navigator.service.dart';
import 'src/features/home/presentation/cubit/home_cubit.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthWapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserCubit()..init()),
          BlocProvider(create: (_) => HomeCubit()..init()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, ch) => DismissKeyboard(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: NavigatorService.navigatorKey,
              localizationsDelegates: AppLocalization.localizationsDelegates,
              supportedLocales: AppLocalization.supportedLocales,
              initialRoute: RoutesName.initial,
              onGenerateRoute: AppRoute.generate,
            ),
          ),
        ),
      ),
    );
  }
}
