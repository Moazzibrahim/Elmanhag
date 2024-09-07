class Subject {
  final int id;
  final String name;
  final int price;
  final int categoryId;
  final int? educationId; // Nullable
  final String? demoVideo; // Nullable
  final String? coverPhoto; // Nullable
  final String? thumbnail; // Nullable
  final String url;
  final String? description; // Nullable
  final int status;
  final String? semester; // Nullable
  final String? expiredDate; // Nullable
  final String? createdAt; // Nullable
  final String? updatedAt; // Nullable
  final String? demoVideoUrl; // Nullable
  final String? coverPhotoUrl; // Nullable
  final String? thumbnailUrl; // Nullable

  Subject({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
    this.educationId,
    this.demoVideo,
    this.coverPhoto,
    this.thumbnail,
    required this.url,
    this.description,
    required this.status,
    this.semester,
    this.expiredDate,
    this.createdAt,
    this.updatedAt,
    this.demoVideoUrl,
    this.coverPhotoUrl,
    this.thumbnailUrl,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'] ?? '', // Default empty string if null
      price: json['price'],
      categoryId: json['category_id'],
      educationId: json['education_id'],
      demoVideo: json['demo_video'], // Nullable
      coverPhoto: json['cover_photo'], // Nullable
      thumbnail: json['thumbnail'], // Nullable
      url: json['url'] ?? '', // Default empty string if null
      description: json['description'], // Nullable
      status: json['status'],
      semester: json['semester'], // Nullable
      expiredDate: json['expired_date'], // Nullable
      createdAt: json['created_at'], // Nullable
      updatedAt: json['updated_at'], // Nullable
      demoVideoUrl: json['demo_video_url'], // Nullable
      coverPhotoUrl: json['cover_photo_url'], // Nullable
      thumbnailUrl: json['thumbnail_url'], // Nullable
    );
  }
}


class SubjectResponse {
  final String success;
  final List<Subject> subjects;

  SubjectResponse({required this.success, required this.subjects});

  factory SubjectResponse.fromJson(Map<String, dynamic> json) {
    return SubjectResponse(
      success: json['success'],
      subjects:
          (json['subject'] as List).map((i) => Subject.fromJson(i)).toList(),
    );
  }
}
