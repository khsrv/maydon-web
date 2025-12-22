class VideoEntity {
  final String id;
  final String name;
  final String link;

  const VideoEntity({
    required this.id,
    required this.name,
    required this.link,
  });

  factory VideoEntity.fromMap(Map<String, dynamic> map, String id) {
    return VideoEntity(
      id: id,
      name: map['name'] as String? ?? '',
      link: map['link'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'link': link,
    };
  }
}

