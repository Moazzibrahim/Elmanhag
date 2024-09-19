class AffiliateGroupVideo {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  List<AffiliateVideo> affiliateVideos;

  AffiliateGroupVideo({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.affiliateVideos,
  });

  factory AffiliateGroupVideo.fromJson(Map<String, dynamic> json) {
    return AffiliateGroupVideo(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      affiliateVideos: (json['affilate_videos'] as List)
          .map((video) => AffiliateVideo.fromJson(video))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'affilate_videos':
          affiliateVideos.map((video) => video.toJson()).toList(),
    };
  }
}

class AffiliateVideo {
  int id;
  String title;
  String video;
  int affiliateGroupVideoId;
  DateTime createdAt;
  DateTime updatedAt;
  String videoLink;

  AffiliateVideo({
    required this.id,
    required this.title,
    required this.video,
    required this.affiliateGroupVideoId,
    required this.createdAt,
    required this.updatedAt,
    required this.videoLink,
  });

  factory AffiliateVideo.fromJson(Map<String, dynamic> json) {
    return AffiliateVideo(
      id: json['id'],
      title: json['title'],
      video: json['video'],
      affiliateGroupVideoId: json['affilate_group_video_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      videoLink: json['video_link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'video': video,
      'affilate_group_video_id': affiliateGroupVideoId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'video_link': videoLink,
    };
  }
}
