import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:postj/features/onboarding/domain/services/first_run_checker.dart';

part 'onboarding_state.dart';
part 'onboarding_cubit.freezed.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._checker) : super(const OnboardingState.loading());
  final FirstRunChecker _checker;

  Future<void> init() async {
    emit(OnboardingState.loading());
    final first = await _checker.isFirstRun();
        log("_checker $first");

    emit(
      first ? const OnboardingState.needs() : const OnboardingState.skipped(),
    );
  }

  /// Пользователь прошёл онбординг
  void complete() {
    emit(const OnboardingState.completed());
  }
}
