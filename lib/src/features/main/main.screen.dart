import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zen_fit_hub/src/features/home/presentation/pages/exercise.dart';
import 'package:zen_fit_hub/src/features/home/presentation/pages/home.dart';
import 'package:zen_fit_hub/src/features/main/cubit/bottom.navigation.dart';
import '../home/presentation/pages/meals.dart';
import '../profile/presentation/pages/profile.dart';
import 'widget/custom.bottom.bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: Scaffold(
        body: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
          builder: (context, state) {
            return PageView.builder(
              itemCount: pages.length,
              physics: const NeverScrollableScrollPhysics(),
              controller: state.controller,
              itemBuilder: (_, index) => pages[index],
            );
          },
        ),
        bottomNavigationBar: const CustomBottomBar(),
      ),
    );
  }
}

List<Widget> pages = [
  const HomePage(),
  const MealplanPage(),
  const ExercisePage(),
  const ProfilePage(),
];
