part of 'onboarding_cubit.dart';

@freezed
sealed class OnboardingState with _$OnboardingState {
  const factory OnboardingState.loading() = _Loading;
  /// Нужно показать онбординг (первый запуск)
  const factory OnboardingState.needs() = _Needs;
  /// Онбординг уже не нужен (не первый запуск)
  const factory OnboardingState.skipped() = _Skipped;
  /// Пользователь завершил онбординг в этом сеансе
  const factory OnboardingState.completed() = _Completed;
}
