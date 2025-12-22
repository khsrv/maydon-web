part of 'version_check_cubit.dart';

sealed class VersionCheckState {
  const VersionCheckState();
}

class VersionCheckLoading extends VersionCheckState {
  const VersionCheckLoading();
}

class VersionCheckUpToDate extends VersionCheckState {
  const VersionCheckUpToDate();
}

class VersionCheckUpdateRequired extends VersionCheckState {
  const VersionCheckUpdateRequired();
}

class VersionCheckError extends VersionCheckState {
  final String message;
  const VersionCheckError(this.message);
}

