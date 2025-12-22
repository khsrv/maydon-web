import 'package:is_first_run/is_first_run.dart';
import 'package:postj/features/onboarding/domain/services/first_run_checker.dart';

class IsFirstRunChecker implements FirstRunChecker {
  @override
  Future<bool> isFirstRun() => IsFirstRun.isFirstRun();
}
