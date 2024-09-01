class UserResponse {
  final String? success;
  final User? user;

  UserResponse({
    this.success,
    this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'user': user?.toJson(),
    };
  }
}

class User {
  final int? id;
  final String? name;
  final String? phone;
  final String? image;
  final String? role;
  final String? gender;
  final String? email;
  final String? emailVerifiedAt;
  final int? parentRelationId;
  final int? categoryId;
  final int? countryId;
  final int? cityId;
  final int? studentId;
  final int? educationId;
  final int? studentJobsId;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final String? education;
  final String? countryName;
  final String? cityName;
  final String? imageLink;
  final Country? country;
  final City? city;
  final Category? category;
  final StudentJob? studentJob;
  final Parent? parent;

  User({
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
    this.studentId,
    this.educationId,
    this.studentJobsId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.education,
    this.countryName,
    this.cityName,
    this.imageLink,
    this.country,
    this.city,
    this.category,
    this.studentJob,
    this.parent,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
      studentId: json['student_id'],
      educationId: json['education_id'],
      studentJobsId: json['sudent_jobs_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      education: json['education'],
      countryName: json['country_name'],
      cityName: json['city_name'],
      imageLink: json['image_link'],
      country: json['country'] != null ? Country.fromJson(json['country']) : null,
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      studentJob: json['student_jobs'] != null ? StudentJob.fromJson(json['student_jobs']) : null,
      parent: json['parents'] != null ? Parent.fromJson(json['parents']) : null,
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
      'student_id': studentId,
      'education_id': educationId,
      'sudent_jobs_id': studentJobsId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'education': education,
      'country_name': countryName,
      'city_name': cityName,
      'image_link': imageLink,
      'country': country?.toJson(),
      'city': city?.toJson(),
      'category': category?.toJson(),
      'student_jobs': studentJob?.toJson(),
      'parents': parent?.toJson(),
    };
  }
}

class Country {
  final int? id;
  final String? name;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  Country({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class City {
  final int? id;
  final String? name;
  final int? countryId;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  City({
    this.id,
    this.name,
    this.countryId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      countryId: json['country_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country_id': countryId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Category {
  final int? id;
  final String? name;
  final String? thumbnail;
  final String? tags;
  final int? order;
  final int? categoryId;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final String? thumbnailLink;

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

class StudentJob {
  final int? id;
  final String? job;
  final String? titleMale;
  final String? titleFemale;
  final String? createdAt;
  final String? updatedAt;

  StudentJob({
    this.id,
    this.job,
    this.titleMale,
    this.titleFemale,
    this.createdAt,
    this.updatedAt,
  });

  factory StudentJob.fromJson(Map<String, dynamic> json) {
    return StudentJob(
      id: json['id'],
      job: json['job'],
      titleMale: json['title_male'],
      titleFemale: json['title_female'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job': job,
      'title_male': titleMale,
      'title_female': titleFemale,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Parent {
  final int? id;
  final String? name;
  final String? phone;
  final String? image;
  final String? role;
  final String? gender;
  final String? email;
  final String? emailVerifiedAt;
  final int? parentRelationId;
  final int? categoryId;
  final int? countryId;
  final int? cityId;
  final int? studentId;
  final int? educationId;
  final int? studentJobsId;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final String? imageLink;

  Parent({
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
    this.studentId,
    this.educationId,
    this.studentJobsId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.imageLink,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
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
      studentId: json['student_id'],
      educationId: json['education_id'],
      studentJobsId: json['sudent_jobs_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
      'email_verified_at': emailVerifiedAt,
      'parent_relation_id': parentRelationId,
      'category_id': categoryId,
      'country_id': countryId,
      'city_id': cityId,
      'student_id': studentId,
      'education_id': educationId,
      'sudent_jobs_id': studentJobsId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image_link': imageLink,
    };
  }
}
