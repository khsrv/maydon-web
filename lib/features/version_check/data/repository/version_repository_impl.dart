import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/version_entity.dart';
import '../../domain/repository/version_repository.dart';

class VersionRepositoryImpl implements VersionRepository {
  final FirebaseFirestore _firestore;

  VersionRepositoryImpl(this._firestore);

  @override
  Future<VersionEntity> getMinimumVersion() async {
    try {
      // Сначала пробуем получить документ с ID 'current'
      var doc = await _firestore
          .collection('version')
          .doc('current')
          .get(const GetOptions(source: Source.serverAndCache))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception('Connection timeout');
            },
          );

      // Если документа 'current' нет, пробуем получить первый документ из коллекции
      if (!doc.exists) {
        log('Version Check: Document version/current does not exist, trying to get first document...');
        final querySnapshot = await _firestore
            .collection('version')
            .limit(1)
            .get(const GetOptions(source: Source.serverAndCache))
            .timeout(
              const Duration(seconds: 10),
              onTimeout: () {
                throw Exception('Connection timeout');
              },
            );

        if (querySnapshot.docs.isEmpty) {
          log('Version Check: No documents found in version collection');
          return const VersionEntity(minimumVersion: 0);
        }

        doc = querySnapshot.docs.first;
        log('Version Check: Using document with ID: ${doc.id}');
      }

      final data = doc.data();
      if (data == null) {
        log('Version Check: Document exists but data is null');
        return const VersionEntity(minimumVersion: 0);
      }

      log('Version Check: Firestore data = $data');
      log('Version Check: Data type of "number" field = ${data['number']?.runtimeType}');
      log('Version Check: Raw "number" value = ${data['number']}');
      
      final versionEntity = VersionEntity.fromMap(Map<String, dynamic>.from(data));
      log('Version Check: Parsed minimumVersion = ${versionEntity.minimumVersion}');
      return versionEntity;
    } on FirebaseException catch (e) {
      log('Version Check: FirebaseException - ${e.code}: ${e.message}');
      // При ошибке Firestore не блокируем приложение
      // Можно логировать ошибку, но позволяем пользователю продолжить
      return const VersionEntity(minimumVersion: 0);
    } catch (e) {
      log('Version Check: General error - $e');
      // При любой другой ошибке не блокируем
      return const VersionEntity(minimumVersion: 0);
    }
  }
}

