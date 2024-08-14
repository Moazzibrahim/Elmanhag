class UserResponse {
  final String success;
  final User user;

  UserResponse({
    required this.success,
    required this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'user': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String name;
  final String phone;
  final String image;
  final String role;
  final String email;
  final String emailVerifiedAt;
  final int? parentRelationId;
  final int categoryId;
  final int countryId;
  final int cityId;
  final int? studentId;
  final int? educationId;
  final int status;
  final String createdAt;
  final String updatedAt;
  final Country country;
  final City city;
  final List<dynamic> parents;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.image,
    required this.role,
    required this.email,
    required this.emailVerifiedAt,
    this.parentRelationId,
    required this.categoryId,
    required this.countryId,
    required this.cityId,
    this.studentId,
    this.educationId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.country,
    required this.city,
    required this.parents,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      image: json['image'],
      role: json['role'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      parentRelationId: json['parent_relation_id'],
      categoryId: json['category_id'],
      countryId: json['country_id'],
      cityId: json['city_id'],
      studentId: json['student_id'],
      educationId: json['education_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      country: Country.fromJson(json['country']),
      city: City.fromJson(json['city']),
      parents: List<dynamic>.from(json['parents']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'image': image,
      'role': role,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'parent_relation_id': parentRelationId,
      'category_id': categoryId,
      'country_id': countryId,
      'city_id': cityId,
      'student_id': studentId,
      'education_id': educationId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'country': country.toJson(),
      'city': city.toJson(),
      'parents': parents,
    };
  }
}

class Country {
  final int id;
  final String name;
  final int status;
  final String createdAt;
  final String updatedAt;

  Country({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
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
  final int id;
  final String name;
  final int? countryId;
  final int status;
  final String createdAt;
  final String updatedAt;

  City({
    required this.id,
    required this.name,
    this.countryId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
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
