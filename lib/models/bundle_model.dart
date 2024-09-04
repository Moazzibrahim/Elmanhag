class MainModel {
  final List<Bundle>? bundles;
  final List<Subject>? subjects;
  final List<dynamic>? live;

  MainModel({
    this.bundles,
    this.subjects,
    this.live,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) {
    return MainModel(
      bundles: json['bundles'] != null
          ? (json['bundles'] as List)
              .map((item) => Bundle.fromJson(item))
              .toList()
          : null,
      subjects: json['subjects'] != null
          ? (json['subjects'] as List)
              .map((item) => Subject.fromJson(item))
              .toList()
          : null,
      live: json['live'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bundles': bundles?.map((bundle) => bundle.toJson()).toList(),
      'subjects': subjects?.map((subject) => subject.toJson()).toList(),
      'live': live,
    };
  }
}
class Bundle {
  final int? id;
  final String? name;
  final double? price;
  final String? tags;
  final String? thumbnail;
  final String? coverPhoto;
  final String? demoVideo;
  final String? url;
  final String? description;
  final String? semester;
  final int? categoryId;
  final int? educationId;
  final String? expiredDate;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Bundle({
    this.id,
    this.name,
    this.price,
    this.tags,
    this.thumbnail,
    this.coverPhoto,
    this.demoVideo,
    this.url,
    this.description,
    this.semester,
    this.categoryId,
    this.educationId,
    this.expiredDate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Bundle.fromJson(Map<String, dynamic> json) {
    return Bundle(
      id: json['id'],
      name: json['name'],
      price: json['price']?.toDouble(),
      tags: json['tags'],
      thumbnail: json['thumbnail'],
      coverPhoto: json['cover_photo'],
      demoVideo: json['demo_video'],
      url: json['url'],
      description: json['description'],
      semester: json['semester'],
      categoryId: json['category_id'],
      educationId: json['education_id'],
      expiredDate: json['expired_date'],
      status: json['status'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'tags': tags,
      'thumbnail': thumbnail,
      'cover_photo': coverPhoto,
      'demo_video': demoVideo,
      'url': url,
      'description': description,
      'semester': semester,
      'category_id': categoryId,
      'education_id': educationId,
      'expired_date': expiredDate,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
class Subject {
  final int? id;
  final String? name;
  final double? price;
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? demoVideoUrl;
  final String? coverPhotoUrl;
  final String? thumbnailUrl;

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
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      price: json['price']?.toDouble(),
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
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      demoVideoUrl: json['demo_video_url'],
      coverPhotoUrl: json['cover_photo_url'],
      thumbnailUrl: json['thumbnail_url'],
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
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'demo_video_url': demoVideoUrl,
      'cover_photo_url': coverPhotoUrl,
      'thumbnail_url': thumbnailUrl,
    };
  }
}
