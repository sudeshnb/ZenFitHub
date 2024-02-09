import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zen_fit_hub/src/core/config/auth.dart';

import '../bloc/auth/app_bloc.dart';

class AuthWapper extends StatelessWidget {
  const AuthWapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: Auth.authRepo,
      child: BlocProvider(
        create: (_) => AppBloc(authRepo: Auth.authRepo),
        child: child,
      ),
    );
  }
}
