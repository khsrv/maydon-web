part of 'videos_cubit.dart';

sealed class VideosState {
  const VideosState();
}

class VideosLoading extends VideosState {
  const VideosLoading();
}

class VideosLoaded extends VideosState {
  final List<VideoEntity> videos;
  const VideosLoaded(this.videos);
}

class VideosError extends VideosState {
  final String message;
  const VideosError(this.message);
}

