class VersionEntity {
  final int minimumVersion;

  const VersionEntity({
    required this.minimumVersion,
  });

  factory VersionEntity.fromMap(Map<String, dynamic> map) {
    // Пробуем разные варианты названий полей
    final number = map['number'] ?? map['minimumVersion'] ?? map['version'];
    
    if (number == null) {
      return const VersionEntity(minimumVersion: 0);
    }
    
    // Обрабатываем разные типы данных
    if (number is int) {
      return VersionEntity(minimumVersion: number);
    } else if (number is num) {
      return VersionEntity(minimumVersion: number.toInt());
    } else if (number is String) {
      // Убираем пробелы и пробуем распарсить
      final cleaned = number.trim();
      final parsed = int.tryParse(cleaned);
      if (parsed == null) {
        // Если не удалось распарсить, возвращаем 0
        return const VersionEntity(minimumVersion: 0);
      }
      return VersionEntity(minimumVersion: parsed);
    }
    
    return const VersionEntity(minimumVersion: 0);
  }

  Map<String, dynamic> toMap() {
    return {
      'number': minimumVersion,
    };
  }
}

