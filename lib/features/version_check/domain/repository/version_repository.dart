import '../entities/version_entity.dart';

abstract class VersionRepository {
  Future<VersionEntity> getMinimumVersion();
}

