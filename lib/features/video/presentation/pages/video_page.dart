import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:postj/features/video/domain/entities/video_entity.dart';
import 'package:postj/features/video/presentation/cubit/videos_cubit.dart';
import 'package:postj/l10n/app_localizations.dart';
import 'package:postj/src/theme/app_theme.dart';
import 'package:postj/src/widgets/overlay_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<VideosCubit>().loadVideos();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    context.read<VideosCubit>().searchVideos(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openVideo(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  String? _extractVideoId(String url) {
    try {
      final uri = Uri.parse(url);
      final host = uri.host.toLowerCase();
      
      // Обработка youtu.be ссылок: https://youtu.be/VIDEO_ID
      if (host.contains('youtu.be')) {
        final path = uri.path;
        if (path.isNotEmpty && path.length > 1) {
          return path.substring(1).split('?').first; // Убираем / в начале и query параметры
        }
      }
      
      // Обработка youtube.com ссылок: https://www.youtube.com/watch?v=VIDEO_ID
      if (host.contains('youtube.com')) {
        // Пробуем получить из query параметра v
        final videoId = uri.queryParameters['v'];
        if (videoId != null && videoId.isNotEmpty) {
          return videoId.split('&').first; // Убираем дополнительные параметры
        }
        
        // Для embed ссылок: https://www.youtube.com/embed/VIDEO_ID
        if (uri.pathSegments.isNotEmpty && uri.pathSegments.contains('embed')) {
          final embedIndex = uri.pathSegments.indexOf('embed');
          if (embedIndex >= 0 && embedIndex < uri.pathSegments.length - 1) {
            return uri.pathSegments[embedIndex + 1].split('?').first;
          }
        }
        
        // Для коротких ссылок: https://youtube.com/shorts/VIDEO_ID
        if (uri.pathSegments.isNotEmpty && uri.pathSegments.contains('shorts')) {
          final shortsIndex = uri.pathSegments.indexOf('shorts');
          if (shortsIndex >= 0 && shortsIndex < uri.pathSegments.length - 1) {
            return uri.pathSegments[shortsIndex + 1].split('?').first;
          }
        }
      }
    } catch (e) {
      debugPrint('Error extracting video ID from URL: $url - $e');
      return null;
    }
    return null;
  }

  String _getThumbnailUrl(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/mqdefault.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        if (context.mounted) {
          context.go('/');
        }
      },
      child: Scaffold(
        backgroundColor: kWebViewBgLight,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Контент с отступом сверху для AppBar и поиска
            Padding(
              padding: const EdgeInsets.only(top: 180),
              child: BlocBuilder<VideosCubit, VideosState>(
                builder: (context, state) {
                  if (state is VideosLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: kWebViewHeaderBlue,
                      ),
                    );
                  }
                  if (state is VideosLoaded) {
                    final videos = state.videos;
                    if (videos.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.videocam_off,
                              size: 80,
                              color: kGrey,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              l10n.videoComingSoon,
                              style: const TextStyle(
                                fontSize: 18,
                                color: kGrey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final video = videos[index];
                        final videoId = _extractVideoId(video.link);
                        final thumbnailUrl = videoId != null
                            ? _getThumbnailUrl(videoId)
                            : null;
                        
                        // Отладка
                        if (videoId == null) {
                          debugPrint('Could not extract video ID from: ${video.link}');
                        } else {
                          debugPrint('Video ID: $videoId, Thumbnail: $thumbnailUrl');
                        }
                        
                        return _VideoCard(
                          video: video,
                          thumbnailUrl: thumbnailUrl,
                          onTap: () => _openVideo(video.link),
                        );
                      },
                    );
                  }
                  if (state is VideosError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 80,
                              color: kRed,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              state.message,
                              style: const TextStyle(
                                fontSize: 16,
                                color: kGrey,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<VideosCubit>().loadVideos(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kWebViewHeaderBlue,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Повторить',
                                style: TextStyle(color: kWhite),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            // AppBar и поиск
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  OverlayAppBar(
                    title: Text(l10n.video),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: kWhite),
                      onPressed: () => context.go('/'),
                    ),
                  ),
                  // Поиск
                  Container(
                    color: kWebViewHeaderBlue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: kWhite),
                      decoration: InputDecoration(
                        hintText: 'Поиск...',
                        hintStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white70,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  const _VideoCard({
    required this.video,
    this.thumbnailUrl,
    required this.onTap,
  });

  final VideoEntity video;
  final String? thumbnailUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: kGrey.withOpacity(0.2),
                    child: thumbnailUrl != null
                        ? CachedNetworkImage(
                            imageUrl: thumbnailUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: kGrey.withOpacity(0.2),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: kWebViewHeaderBlue,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) {
                              debugPrint('Error loading thumbnail: $url - $error');
                              return Container(
                                color: kGrey.withOpacity(0.2),
                                child: const Center(
                                  child: Icon(
                                    Icons.videocam,
                                    size: 64,
                                    color: kGrey,
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: kGrey.withOpacity(0.2),
                            child: const Center(
                              child: Icon(Icons.videocam, size: 64, color: kGrey),
                            ),
                          ),
                  ),
                  // Play button overlay
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_filled,
                          size: 64,
                          color: kWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                video.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kBlack,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
