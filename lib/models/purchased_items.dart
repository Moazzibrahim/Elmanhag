class DataModelss {
  List<Subjectss>? subjects;
  List<Livess>? live;

  DataModelss({this.subjects, this.live});

  factory DataModelss.fromJson(Map<String, dynamic> json) {
    return DataModelss(
      subjects: (json['subjects'] as List?)?.map((e) => Subjectss.fromJson(e)).toList(),
      live: (json['live'] as List?)?.map((e) => Livess.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjects': subjects?.map((e) => e.toJson()).toList(),
      'live': live?.map((e) => e.toJson()).toList(),
    };
  }
}

class Subjectss {
  int? id;
  String? name;
  int? price;
  String? tags;
  int? categoryId;
  int? educationId;
  String? demoVideo;
  String? coverPhoto;
  String? thumbnail;
  String? url;
  String? description;
  int? status;
  String? semester;
  String? expiredDate;
  String? createdAt;
  String? updatedAt;
  String? demoVideoUrl;
  String? coverPhotoUrl;
  String? thumbnailUrl;

  Subjectss({
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

  factory Subjectss.fromJson(Map<String, dynamic> json) {
    return Subjectss(
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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
      'created_at': createdAt,
      'updated_at': updatedAt,
      'demo_video_url': demoVideoUrl,
      'cover_photo_url': coverPhotoUrl,
      'thumbnail_url': thumbnailUrl,
    };
  }
}

class Livess {
  int? id;
  String? name;
  String? link;
  String? from;
  String? to;
  String? date;
  String? day;
  int? teacherId;
  int? subjectId;
  int? categoryId;
  int? educationId;
  int? paid;
  int? price;
  int? included;
  String? createdAt;
  String? updatedAt;
  int? liveId;
  int? fixed;
  String? endDate;
  Subjectss? subject;
  Teacherss? teacher;

  Livess({
    this.id,
    this.name,
    this.link,
    this.from,
    this.to,
    this.date,
    this.day,
    this.teacherId,
    this.subjectId,
    this.categoryId,
    this.educationId,
    this.paid,
    this.price,
    this.included,
    this.createdAt,
    this.updatedAt,
    this.liveId,
    this.fixed,
    this.endDate,
    this.subject,
    this.teacher,
  });

  factory Livess.fromJson(Map<String, dynamic> json) {
    return Livess(
      id: json['id'],
      name: json['name'],
      link: json['link'],
      from: json['from'],
      to: json['to'],
      date: json['date'],
      day: json['day'],
      teacherId: json['teacher_id'],
      subjectId: json['subject_id'],
      categoryId: json['category_id'],
      educationId: json['education_id'],
      paid: json['paid'],
      price: json['price'],
      included: json['included'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      liveId: json['live_id'],
      fixed: json['fixed'],
      endDate: json['end_date'],
      subject: json['subject'] != null ? Subjectss.fromJson(json['subject']) : null,
      teacher: json['teacher'] != null ? Teacherss.fromJson(json['teacher']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'link': link,
      'from': from,
      'to': to,
      'date': date,
      'day': day,
      'teacher_id': teacherId,
      'subject_id': subjectId,
      'category_id': categoryId,
      'education_id': educationId,
      'paid': paid,
      'price': price,
      'included': included,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'live_id': liveId,
      'fixed': fixed,
      'end_date': endDate,
      'subject': subject?.toJson(),
      'teacher': teacher?.toJson(),
    };
  }
}


class Teacherss {
  int? id;
  String? name;
  String? phone;
  String? image;
  String? role;
  String? gender;
  String? email;
  String? imageLink;

  Teacherss({
    this.id,
    this.name,
    this.phone,
    this.image,
    this.role,
    this.gender,
    this.email,
    this.imageLink,
  });

  factory Teacherss.fromJson(Map<String, dynamic> json) {
    return Teacherss(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      image: json['image'],
      role: json['role'],
      gender: json['gender'],
      email: json['email'],
      imageLink: json['image_link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'image': image,
      'role': role,
      'gender': gender,
      'email': email,
      'image_link': imageLink,
    };
  }
}
