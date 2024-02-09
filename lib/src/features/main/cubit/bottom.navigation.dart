import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit()
      : super(BottomNavigationState(controller: controller));

  static PageController controller = PageController();

  jump(int index) {
    controller.jumpToPage(index);
    emit(state.copyWith(index: index));
  }
}

class BottomNavigationState extends Equatable {
  final PageController controller;
  final int index;
  const BottomNavigationState({required this.controller, this.index = 0});

  @override
  List<Object> get props => [controller, index];

  BottomNavigationState copyWith({
    PageController? controller,
    int? index,
  }) {
    return BottomNavigationState(
      controller: controller ?? this.controller,
      index: index ?? this.index,
    );
  }
}
