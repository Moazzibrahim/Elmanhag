class Lesson {
  final int id;
  final String name;
  final String description;
  final int paid;
  final int chapterId;
  final int status;
  final int order;
  final int dripContent;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Resource> resources;
  final List<Homework> homework;

  Lesson({
    required this.id,
    required this.name,
    required this.description,
    required this.paid,
    required this.chapterId,
    required this.status,
    required this.order,
    required this.dripContent,
    required this.createdAt,
    required this.updatedAt,
    required this.resources,
    required this.homework,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      paid: json['paid'],
      chapterId: json['chapter_id'],
      status: json['status'],
      order: json['order'],
      dripContent: json['drip_content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      resources: (json['resources'] as List<dynamic>)
          .map((resource) => Resource.fromJson(resource))
          .toList(),
      homework: (json['homework'] as List<dynamic>)
          .map((hw) => Homework.fromJson(hw))
          .toList(),
    );
  }
}

class Resource {
  final int id;
  final String type;
  final String source;
  final int lessonId;
  final String file;
  final String? link;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? fileLink;

  Resource({
    required this.id,
    required this.type,
    required this.source,
    required this.lessonId,
    required this.file,
    this.link,
    this.createdAt,
    this.updatedAt,
    this.fileLink,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      id: json['id'],
      type: json['type'],
      source: json['source'],
      lessonId: json['lesson_id'],
      file: json['file'],
      link: json['link'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      fileLink: json['file_link'],
    );
  }
}

class Homework {
  final int id;
  final String title;
  final String semester;
  final int categoryId;
  final int subjectId;
  final int chapterId;
  final int lessonId;
  final String difficulty;
  final int mark;
  final int pass;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Homework({
    required this.id,
    required this.title,
    required this.semester,
    required this.categoryId,
    required this.subjectId,
    required this.chapterId,
    required this.lessonId,
    required this.difficulty,
    required this.mark,
    required this.pass,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Homework.fromJson(Map<String, dynamic> json) {
    return Homework(
      id: json['id'],
      title: json['title'],
      semester: json['semester'],
      categoryId: json['category_id'],
      subjectId: json['subject_id'],
      chapterId: json['chapter_id'],
      lessonId: json['lesson_id'],
      difficulty: json['difficulty'],
      mark: json['mark'],
      pass: json['pass'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
