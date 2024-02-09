import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zen_fit_hub/src/core/routes/routes.dart';
import 'package:zen_fit_hub/src/core/services/services.dart';
import 'package:zen_fit_hub/src/features/auth/presentation/bloc/auth/app_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState());

  execute(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 3000), () {
      final state = context.read<AppBloc>().state.status;
      NavigatorService.popAndPush(AppRoute.onAppView(state));
    });
  }
}

class SplashState extends Equatable {
  @override
  List<Object> get props => [];
}
