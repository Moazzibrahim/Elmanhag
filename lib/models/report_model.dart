class IssuesData {
  List<QuestionIssue> questionIssues;
  List<VideoIssue> videoIssues;

  IssuesData({
    required this.questionIssues,
    required this.videoIssues,
  });

  factory IssuesData.fromJson(Map<String, dynamic> json) {
    var questionIssuesList = json['question_issues'] as List;
    var videoIssuesList = json['video_issues'] as List;

    return IssuesData(
      questionIssues: questionIssuesList
          .map((issue) => QuestionIssue.fromJson(issue))
          .toList(),
      videoIssues:
          videoIssuesList.map((issue) => VideoIssue.fromJson(issue)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_issues': questionIssues.map((issue) => issue.toJson()).toList(),
      'video_issues': videoIssues.map((issue) => issue.toJson()).toList(),
    };
  }
}

class QuestionIssue {
  int? id;
  String? title;
  String? thumbnail;
  String? description;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  QuestionIssue({
    this.id,
    this.title,
    this.thumbnail,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory QuestionIssue.fromJson(Map<String, dynamic> json) {
    return QuestionIssue(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      description: json['description'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'description': description,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class VideoIssue {
  int? id;
  String? title;
  String? thumbnail;
  String? description;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  VideoIssue({
    this.id,
    this.title,
    this.thumbnail,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory VideoIssue.fromJson(Map<String, dynamic> json) {
    return VideoIssue(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      description: json['description'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'description': description,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
