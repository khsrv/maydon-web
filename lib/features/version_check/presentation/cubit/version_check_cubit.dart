import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../domain/repository/version_repository.dart';

part 'version_check_state.dart';

class VersionCheckCubit extends Cubit<VersionCheckState> {
  VersionCheckCubit(this._repository) : super(const VersionCheckLoading());

  final VersionRepository _repository;

  Future<void> checkVersion() async {
    emit(const VersionCheckLoading());
    
    try {
      // Получаем текущую версию приложения (build number)
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersionCode = int.tryParse(packageInfo.buildNumber) ?? 0;
      
      log('Version Check: Current buildNumber = ${packageInfo.buildNumber}, parsed = $currentVersionCode');
      log('Version Check: version = ${packageInfo.version}, packageName = ${packageInfo.packageName}');
      
      // Получаем минимальную требуемую версию из Firestore
      final versionEntity = await _repository.getMinimumVersion();
      
      log('Version Check: Minimum version from Firestore = ${versionEntity.minimumVersion}');
      
      // Если минимальная версия = 0, значит проверка отключена
      if (versionEntity.minimumVersion == 0) {
        log('Version Check: Minimum version is 0, skipping check');
        emit(const VersionCheckUpToDate());
        return;
      }
      
      // Сравниваем версии: если текущая версия меньше минимальной - требуется обновление
      log('Version Check: Comparing $currentVersionCode < ${versionEntity.minimumVersion}');
      if (currentVersionCode < versionEntity.minimumVersion) {
        log('Version Check: Update required!');
        emit(const VersionCheckUpdateRequired());
      } else {
        log('Version Check: Version is up to date');
        emit(const VersionCheckUpToDate());
      }
    } catch (e) {
      log('Version Check: Error - $e');
      // Если плагин не зарегистрирован (MissingPluginException), 
      // это значит проект не пересобран после добавления плагина
      if (e.toString().contains('MissingPluginException')) {
        log('Version Check: package_info_plus plugin not registered. Please rebuild the app (not hot reload).');
      }
      // При ошибке не блокируем приложение, позволяем продолжить
      emit(const VersionCheckUpToDate());
    }
  }
}

