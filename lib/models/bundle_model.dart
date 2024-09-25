class MainModel {
  final List<Bundle>? bundles;
  final List<Subject>? subjects;
  final List<LiveClass>? live; // Change dynamic to List<LiveClass>

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
      live: json['live'] != null
          ? (json['live'] as List)
              .map((item) => LiveClass.fromJson(item))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bundles': bundles?.map((bundle) => bundle.toJson()).toList(),
      'subjects': subjects?.map((subject) => subject.toJson()).toList(),
      'live': live
          ?.map((liveClass) => liveClass.toJson())
          .toList(), // Use LiveClass
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
  final List<Discount>? discounts;

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
    this.discounts,
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
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      discounts: json['discount'] != null
          ? (json['discount'] as List)
              .map((item) => Discount.fromJson(item))
              .toList()
          : null,
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
      'discount': discounts?.map((discount) => discount.toJson()).toList(),
    };
  }
}

class Discount {
  final int? id;
  final int? categoryId;
  final double? amount;
  final String? type;
  final String? description;
  final String? startDate;
  final String? endDate;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pivot? pivot;

  Discount({
    this.id,
    this.categoryId,
    this.amount,
    this.type,
    this.description,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      id: json['id'],
      categoryId: json['category_id'],
      amount: json['amount']?.toDouble(),
      type: json['type'],
      description: json['description'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      status: json['statue'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'amount': amount,
      'type': type,
      'description': description,
      'start_date': startDate,
      'end_date': endDate,
      'statue': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'pivot': pivot?.toJson(),
    };
  }
}

class Pivot {
  final int? bundleId;
  final int? discountId;

  Pivot({this.bundleId, this.discountId});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      bundleId: json['bundle_id'],
      discountId: json['discount_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bundle_id': bundleId,
      'discount_id': discountId,
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
  final List<Discount>? discounts;
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
    this.discounts,
    this.chapters,
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
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      demoVideoUrl: json['demo_video_url'],
      coverPhotoUrl: json['cover_photo_url'],
      thumbnailUrl: json['thumbnail_url'],
      discounts: json['discount'] != null
          ? (json['discount'] as List)
              .map((item) => Discount.fromJson(item))
              .toList()
          : null,
      chapters: json['chapters'] != null
          ? (json['chapters'] as List)
              .map((item) => Chapter.fromJson(item))
              .toList()
          : null,
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
      'discount': discounts?.map((discount) => discount.toJson()).toList(),
      'chapters': chapters?.map((chapter) => chapter.toJson()).toList(),
    };
  }
}

class Chapter {
  final int? id;
  final String? name;
  final String? description;
  final int? subid;
  final String? coverphoto;
  final String? thumbnaill;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Chapter(
      {this.id,
      this.name,
      this.description,
      this.subid,
      this.coverphoto,
      this.thumbnaill,
      this.createdAt,
      this.updatedAt});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      subid: json['subject_id'],
      coverphoto: json['cover_photo'],
      thumbnaill: json['thumbnail'],
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
      'name': name,
      'description': description,
      'subject_id': subid,
      'cover_photo': coverphoto,
      'thumbnail': thumbnaill,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class LiveClass {
  final int? id;
  final String? name;
  final String? link;
  final String? from;
  final String? to;
  final String? date;
  final String? day;
  final int? teacherId;
  final int? subjectId;
  final int? categoryId;
  final int? educationId;
  final int? paid;
  final double? price;
  final int?
      included; // Note: "included" might be a typo in the data; ensure it's correct

  LiveClass({
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
  });

  factory LiveClass.fromJson(Map<String, dynamic> json) {
    return LiveClass(
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
      price: json['price']?.toDouble(),
      included: json['inculded'], // Ensure this matches your API response
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
      'inculded': included, // Ensure this matches your API response
    };
  }
}
