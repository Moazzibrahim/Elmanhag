class Subject {
  final int id;
  final String name;
  final int price;
  final int categoryId;
  final int? educationId; // Make this field nullable
  final String demoVideo;
  final String coverPhoto;
  final String thumbnail;
  final String url;
  final String description;
  final int status;
  final String semester;
  final String expiredDate;
  final String createdAt;
  final String updatedAt;
  final String demoVideoUrl;
  final String coverPhotoUrl;
  final String thumbnailUrl;

  Subject({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
    this.educationId, // Make this field nullable
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
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      categoryId: json['category_id'],
      educationId: json['education_id'], // Adjusted for nullable type
      demoVideo: json['demo_video'],
      coverPhoto: json['cover_photo'],
      thumbnail: json['thumbnail'],
      url: json['url'],
      description: json['description'],
      status: json['status'],
      semester: json['semester'],
      expiredDate: json['expired_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      demoVideoUrl: json['demo_video_url'],
      coverPhotoUrl: json['cover_photo_url'],
      thumbnailUrl: json['thumbnail_url'],
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
