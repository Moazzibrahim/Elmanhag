class Subject {
  final int? id;
  final String? name;
  final int? price;
  final String? tags;
  final int? categoryId;
  final int? educationId;
  final String? demoVideo;
  final String? coverPhoto;
  final String? thumbnail;
  final String? url;
  final String? description;
  final int? status;
  final String? semester;
  final String? expiredDate;
  final String? createdAt;
  final String? updatedAt;
  final String? demoVideoUrl;
  final String? coverPhotoUrl;
  final String? thumbnailUrl;
  final List<Chapter>? chapters;

  Subject({
    this.id,
    this.name,
    this.price,
    this.tags,
    this.categoryId,
    this.educationId,
    this.demoVideo,
    this.coverPhoto,
    this.thumbnail,
    this.url,
    this.description,
    this.status,
    this.semester,
    this.expiredDate,
    this.createdAt,
    this.updatedAt,
    this.demoVideoUrl,
    this.coverPhotoUrl,
    this.thumbnailUrl,
    this.chapters,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      tags: json['tags'] as String?,
      categoryId: json['category_id'] as int?,
      educationId: json['education_id'] as int?,
      demoVideo: json['demo_video'] as String?,
      coverPhoto: json['cover_photo'] as String?,
      thumbnail: json['thumbnail'] as String?,
      url: json['url'] as String?,
      description: json['description'] as String?,
      status: json['status'] as int?,
      semester: json['semester'] as String?,
      expiredDate: json['expired_date'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      demoVideoUrl: json['demo_video_url'] as String?,
      coverPhotoUrl: json['cover_photo_url'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      chapters: (json['chapters'] as List<dynamic>?)
          ?.map((e) => Chapter.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'created_at': createdAt,
      'updated_at': updatedAt,
      'demo_video_url': demoVideoUrl,
      'cover_photo_url': coverPhotoUrl,
      'thumbnail_url': thumbnailUrl,
      'chapters': chapters?.map((e) => e.toJson()).toList(),
    };
  }
}

class Chapter {
  final int? id;
  final String? name;
  final int? subjectId;
  final String? coverPhoto;
  final String? thumbnail;
  final String? createdAt;
  final String? updatedAt;
  final List<Lesson>? lessons;

  Chapter({
    this.id,
    this.name,
    this.subjectId,
    this.coverPhoto,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
    this.lessons,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'] as int?,
      name: json['name'] as String?,
      subjectId: json['subject_id'] as int?,
      coverPhoto: json['cover_photo'] as String?,
      thumbnail: json['thumbnail'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subject_id': subjectId,
      'cover_photo': coverPhoto,
      'thumbnail': thumbnail,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'lessons': lessons?.map((e) => e.toJson()).toList(),
    };
  }
}

class Lesson {
  final int? id;
  final String? name;
  final String? description;
  final int? paid;
  final int? chapterId;
  final int? status;
  final int? switchValue;
  final int? order;
  final int? dripContent;
  final String? createdAt;
  final String? updatedAt;

  Lesson({
    this.id,
    this.name,
    this.description,
    this.paid,
    this.chapterId,
    this.status,
    this.switchValue,
    this.order,
    this.dripContent,
    this.createdAt,
    this.updatedAt,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      paid: json['paid'] as int?,
      chapterId: json['chapter_id'] as int?,
      status: json['status'] as int?,
      switchValue: json['switch'] as int?,
      order: json['order'] as int?,
      dripContent: json['drip_content'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
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
      'switch': switchValue,
      'order': order,
      'drip_content': dripContent,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class ProgressHistoryModel {
  final Subject? subject;
  final int? progress;

  ProgressHistoryModel({this.subject, this.progress});

  factory ProgressHistoryModel.fromJson(Map<String, dynamic> json) {
    return ProgressHistoryModel(
      subject: json['subject'] != null
          ? Subject.fromJson(json['subject'] as Map<String, dynamic>)
          : null,
      progress: json['progress'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject?.toJson(),
      'progress': progress,
    };
  }
}
