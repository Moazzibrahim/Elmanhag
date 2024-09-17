class SubjectResponsechild {
  List<Subject> subjects;

  SubjectResponsechild({required this.subjects});

  factory SubjectResponsechild.fromJson(Map<String, dynamic> json) {
    return SubjectResponsechild(
      subjects: List<Subject>.from(json['subjects'].map((x) => Subject.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjects': List<dynamic>.from(subjects.map((x) => x.toJson())),
    };
  }
}

class Subject {
  int id;
  String name;
  int price;
  String tags;
  int categoryId;
  int educationId;
  String demoVideo;
  String coverPhoto;
  String thumbnail;
  String url;
  String? description;
  int status;
  String semester;
  String expiredDate;
  DateTime createdAt;
  DateTime updatedAt;
  String demoVideoUrl;
  String coverPhotoUrl;
  String thumbnailUrl;
  List<Chapter> chapters;

  Subject({
    required this.id,
    required this.name,
    required this.price,
    required this.tags,
    required this.categoryId,
    required this.educationId,
    required this.demoVideo,
    required this.coverPhoto,
    required this.thumbnail,
    required this.url,
    this.description,
    required this.status,
    required this.semester,
    required this.expiredDate,
    required this.createdAt,
    required this.updatedAt,
    required this.demoVideoUrl,
    required this.coverPhotoUrl,
    required this.thumbnailUrl,
    required this.chapters,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      tags: json['tags'],
      categoryId: json['category_id'],
      educationId: json['education_id'],
      demoVideo: json['demo_video'],
      coverPhoto: json['cover_photo'],
      thumbnail: json['thumbnail'],
      url: json['url'],
      description: json['description'],
      status: json['status'],
      semester: json['semester'],
      expiredDate: json['expired_date'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      demoVideoUrl: json['demo_video_url'],
      coverPhotoUrl: json['cover_photo_url'],
      thumbnailUrl: json['thumbnail_url'],
      chapters: List<Chapter>.from(json['chapters'].map((x) => Chapter.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'tags': tags,
      'category_id': categoryId,
      'education_id': educationId,
      'demo_video': demoVideo,
      'cover_photo': coverPhoto,
      'thumbnail': thumbnail,
      'url': url,
      'description': description,
      'status': status,
      'semester': semester,
      'expired_date': expiredDate,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'demo_video_url': demoVideoUrl,
      'cover_photo_url': coverPhotoUrl,
      'thumbnail_url': thumbnailUrl,
      'chapters': List<dynamic>.from(chapters.map((x) => x.toJson())),
    };
  }
}

class Chapter {
  int id;
  String name;
  int subjectId;
  String coverPhoto;
  String thumbnail;
  DateTime createdAt;
  DateTime updatedAt;
  List<Lesson> lessons;

  Chapter({
    required this.id,
    required this.name,
    required this.subjectId,
    required this.coverPhoto,
    required this.thumbnail,
    required this.createdAt,
    required this.updatedAt,
    required this.lessons,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      name: json['name'],
      subjectId: json['subject_id'],
      coverPhoto: json['cover_photo'],
      thumbnail: json['thumbnail'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      lessons: List<Lesson>.from(json['lessons'].map((x) => Lesson.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subject_id': subjectId,
      'cover_photo': coverPhoto,
      'thumbnail': thumbnail,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'lessons': List<dynamic>.from(lessons.map((x) => x.toJson())),
    };
  }
}

class Lesson {
  int id;
  String name;
  String description;
  int paid;
  int chapterId;
  int status;
  int switch_;
  int order;
  int dripContent;
  DateTime createdAt;
  DateTime updatedAt;

  Lesson({
    required this.id,
    required this.name,
    required this.description,
    required this.paid,
    required this.chapterId,
    required this.status,
    required this.switch_,
    required this.order,
    required this.dripContent,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      paid: json['paid'],
      chapterId: json['chapter_id'],
      status: json['status'],
      switch_: json['switch'],
      order: json['order'],
      dripContent: json['drip_content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'paid': paid,
      'chapter_id': chapterId,
      'status': status,
      'switch': switch_,
      'order': order,
      'drip_content': dripContent,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
