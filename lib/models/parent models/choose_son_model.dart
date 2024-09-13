class ChildrenResponse {
  List<Child?>? children;

  ChildrenResponse({this.children});

  factory ChildrenResponse.fromJson(Map<String, dynamic> json) {
    return ChildrenResponse(
      children: json['childreen'] != null
          ? List<Child>.from(json['childreen'].map((child) => Child.fromJson(child)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'childreen': children != null
          ? List<dynamic>.from(children!.map((child) => child!.toJson()))
          : null,
    };
  }
}

class Child {
  int? id;
  String? name;
  String? phone;
  String? image;
  String? role;
  String? gender;
  String? email;
  String? emailVerifiedAt;
  int? parentRelationId;
  int? categoryId;
  int? countryId;
  int? cityId;
  int? parentId;
  int? educationId;
  int? studentJobsId;
  int? affiliateId;
  String? affiliateCode;
  int? status;
  int? adminPositionId;
  String? createdAt;
  String? updatedAt;
  String? imageLink;
  Category? category;

  Child({
    this.id,
    this.name,
    this.phone,
    this.image,
    this.role,
    this.gender,
    this.email,
    this.emailVerifiedAt,
    this.parentRelationId,
    this.categoryId,
    this.countryId,
    this.cityId,
    this.parentId,
    this.educationId,
    this.studentJobsId,
    this.affiliateId,
    this.affiliateCode,
    this.status,
    this.adminPositionId,
    this.createdAt,
    this.updatedAt,
    this.imageLink,
    this.category,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      image: json['image'],
      role: json['role'],
      gender: json['gender'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      parentRelationId: json['parent_relation_id'],
      categoryId: json['category_id'],
      countryId: json['country_id'],
      cityId: json['city_id'],
      parentId: json['parent_id'],
      educationId: json['education_id'],
      studentJobsId: json['sudent_jobs_id'],
      affiliateId: json['affilate_id'],
      affiliateCode: json['affilate_code'],
      status: json['status'],
      adminPositionId: json['admin_position_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imageLink: json['image_link'],
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
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
      'email_verified_at': emailVerifiedAt,
      'parent_relation_id': parentRelationId,
      'category_id': categoryId,
      'country_id': countryId,
      'city_id': cityId,
      'parent_id': parentId,
      'education_id': educationId,
      'sudent_jobs_id': studentJobsId,
      'affilate_id': affiliateId,
      'affilate_code': affiliateCode,
      'status': status,
      'admin_position_id': adminPositionId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image_link': imageLink,
      'category': category?.toJson(),
    };
  }
}

class Category {
  int? id;
  String? name;
  String? thumbnail;
  String? tags;
  int? order;
  int? categoryId;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? thumbnailLink;

  Category({
    this.id,
    this.name,
    this.thumbnail,
    this.tags,
    this.order,
    this.categoryId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.thumbnailLink,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      thumbnail: json['thumbnail'],
      tags: json['tags'],
      order: json['order'],
      categoryId: json['category_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      thumbnailLink: json['thumbnail_link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
      'tags': tags,
      'order': order,
      'category_id': categoryId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'thumbnail_link': thumbnailLink,
    };
  }
}
