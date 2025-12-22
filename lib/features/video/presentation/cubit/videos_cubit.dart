import 'package:bloc/bloc.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/repository/video_repository.dart';

part 'videos_state.dart';

class VideosCubit extends Cubit<VideosState> {
  VideosCubit(this._repository) : super(const VideosLoading());

  final VideoRepository _repository;
  List<VideoEntity> _allVideos = [];

  Future<void> loadVideos() async {
    emit(const VideosLoading());
    try {
      final videos = await _repository.getVideos();
      _allVideos = videos;
      emit(VideosLoaded(videos));
    } catch (e) {
      emit(VideosError(e.toString()));
    }
  }

  void searchVideos(String query) {
    if (query.isEmpty) {
      emit(VideosLoaded(_allVideos));
      return;
    }

    final filtered = _allVideos
        .where((video) =>
            video.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(VideosLoaded(filtered));
  }
}

