class Subject {
  int id;
  String name;
  int price;
  int categoryId;
  int? educationId;
  String demoVideo;
  String coverPhoto;
  String thumbnail;
  String url;
  String description;
  int status;
  String semester;
  String expiredDate;
  DateTime createdAt;
  DateTime updatedAt;
  String demoVideoUrl;
  String coverPhotoUrl;
  String thumbnailUrl;
  Pivot pivot;

  Subject({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
    this.educationId,
    required this.demoVideo,
    required this.coverPhoto,
    required this.thumbnail,
    required this.url,
    required this.description,
    required this.status,
    required this.semester,
    required this.expiredDate,
    required this.createdAt,
    required this.updatedAt,
    required this.demoVideoUrl,
    required this.coverPhotoUrl,
    required this.thumbnailUrl,
    required this.pivot,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      price: json['price'],
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
      pivot: Pivot.fromJson(json['pivot']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
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
      'pivot': pivot.toJson(),
    };
  }
}

class Pivot {
  int userId;
  int subjectId;

  Pivot({
    required this.userId,
    required this.subjectId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      userId: json['user_id'],
      subjectId: json['subject_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'subject_id': subjectId,
    };
  }
}

class SubjectResponse {
  String success;
  List<Subject> subjects;

  SubjectResponse({
    required this.success,
    required this.subjects,
  });

  factory SubjectResponse.fromJson(Map<String, dynamic> json) {
    return SubjectResponse(
      success: json['success'],
      subjects: List<Subject>.from(json['subject'].map((x) => Subject.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'subject': List<dynamic>.from(subjects.map((x) => x.toJson())),
    };
  }
}
