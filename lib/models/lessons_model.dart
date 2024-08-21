class Chapter {
  final int id;
  final String name;
  final String coverPhoto;
  final String thumbnail;
  final List<Lesson> lessons;

  Chapter({
    required this.id,
    required this.name,
    required this.coverPhoto,
    required this.thumbnail,
    required this.lessons,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    var lessonsFromJson = json['lessons'] as List;
    List<Lesson> lessonList = lessonsFromJson.map((i) => Lesson.fromJson(i)).toList();

    return Chapter(
      id: json['id'],
      name: json['name'],
      coverPhoto: json['cover_photo'],
      thumbnail: json['thumbnail'],
      lessons: lessonList,
    );
  }
}

class Lesson {
  final int id;
  final String name;
  final String description;

  Lesson({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
