library route_pages;

import 'package:flutter/material.dart';
import 'package:zen_fit_hub/src/features/auth/presentation/bloc/auth/app_bloc.dart';
import 'package:zen_fit_hub/src/features/auth/presentation/pages/forgot.pass.dart';
import 'package:zen_fit_hub/src/features/auth/presentation/pages/login.dart';
import 'package:zen_fit_hub/src/features/auth/presentation/pages/signup.dart';
import 'package:zen_fit_hub/src/features/main/main.screen.dart';
import 'package:zen_fit_hub/src/features/onboard/presentation/pages/onboard.dart';
import 'package:zen_fit_hub/src/features/onboard/presentation/pages/onboard.end.dart';
import 'package:zen_fit_hub/src/features/splash/screens/pages.dart';
import '/src/core/error/error.dart';
import '/src/core/animation/animation.dart';
import 'routes.dart';

class AppRoute {
  static String onAppView(AppStatus state) {
    return switch (state) {
      AppStatus.authenticated => RoutesName.main,
      AppStatus.unauthenticated => RoutesName.onboard,
    };
  }

  static const initial = RoutesName.initial;
  static Route<dynamic> generate(RouteSettings? settings) {
    switch (settings?.name) {
      case RoutesName.initial:
        return _fadeTransition(const SplashPage());

      case RoutesName.onboard:
        return _fadeTransition(const OnBoardPage());

      case RoutesName.onboardEnd:
        return _fadeTransition(const OnboardEndPage());

      case RoutesName.loginScreen:
        return _fadeTransition(const LoginScreen());

      case RoutesName.signUpScreen:
        return _fadeTransition(const SignUpScreen());

      case RoutesName.forgotPasswordScreen:
        return _fadeTransition(const ForgotPassScreen());

      case RoutesName.main:
        return _fadeTransition(const MainScreen());

      default:
        // If there is no such named route in the switch statement
        throw const RouteException('Route not found!');
    }
  }

  static _fadeTransition(Widget child) {
    return AppPageTransition(child: child).build;
  }
}
