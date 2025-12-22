import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/repository/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final FirebaseFirestore _firestore;

  VideoRepositoryImpl(this._firestore);

  @override
  Future<List<VideoEntity>> getVideos() async {
    try {
      // Пробуем получить данные с сервера, с fallback на кэш
      QuerySnapshot snapshot;

      try {
        snapshot = await _firestore
            .collection('videos')
            .get(const GetOptions(source: Source.serverAndCache))
            .timeout(
              const Duration(seconds: 15),
              onTimeout: () {
                throw FirebaseException(
                  plugin: 'cloud_firestore',
                  code: 'deadline-exceeded',
                  message: 'Connection timeout',
                );
              },
            );
      } on FirebaseException catch (e) {
        // Если ошибка связана с правами или подключением, пробуем кэш
        if (e.code == 'permission-denied' ||
            e.code == 'unavailable' ||
            e.code == 'unknown' ||
            e.code == 'deadline-exceeded') {
          try {
            snapshot = await _firestore
                .collection('videos')
                .get(const GetOptions(source: Source.cache));
          } catch (cacheError) {
            // Если и кэш не помог, пробрасываем исходную ошибку
            rethrow;
          }
        } else {
          rethrow;
        }
      }

      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          throw Exception('Document ${doc.id} has null data');
        }
        return VideoEntity.fromMap(data, doc.id);
      }).toList();
    } on FirebaseException catch (e) {
      // Более детальная обработка ошибок Firestore
      String errorMessage;

      switch (e.code) {
        case 'permission-denied':
          errorMessage =
              'Доступ запрещен. Проверьте правила безопасности Firestore:\n'
              'В Firebase Console → Firestore Database → Rules\n'
              'Должно быть: allow read: if true; для коллекции videos';
          break;
        case 'unavailable':
        case 'unknown':
          errorMessage =
              'Не удалось подключиться к Firestore. Проверьте:\n'
              '1. Правила безопасности Firestore (Rules)\n'
              '2. Что Firestore в режиме Native (не Datastore)\n'
              '3. Интернет-соединение\n'
              '4. Что Firestore Database создан в Firebase Console';
          break;
        case 'deadline-exceeded':
          errorMessage =
              'Таймаут подключения. Проверьте интернет-соединение и правила Firestore.';
          break;
        default:
          errorMessage =
              'Ошибка Firestore: ${e.code}\n${e.message ?? "Unknown error"}';
      }

      throw Exception(errorMessage);
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Failed to fetch videos: $e');
    }
  }
}
