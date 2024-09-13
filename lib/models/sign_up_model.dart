class Country {
  final int id;
  final String name;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Country({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      status: json['status'] ?? 0,
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class City {
  final int id;
  final String name;
  final int countryId;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  City({
    required this.id,
    required this.name,
    required this.countryId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      countryId: json['country_id'] ?? 0,
      status: json['status'] ?? 0,
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String thumbnail;
  final String tags;
  final int? categoryId;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.tags,
    required this.categoryId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      thumbnail: json['thumbnail'] ?? '',
      tags: json['tags'] ?? '',
      categoryId: json['category_id'],
      status: json['status'] ?? 0,
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class Education {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Education({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class ParentRelation {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  ParentRelation({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ParentRelation.fromJson(Map<String, dynamic> json) {
    return ParentRelation(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class StudentJob {
  final int id;
  final String job;
  final String titleMale;
  final String titleFemale;
  final DateTime createdAt;
  final DateTime updatedAt;

  StudentJob({
    required this.id,
    required this.job,
    required this.titleMale,
    required this.titleFemale,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentJob.fromJson(Map<String, dynamic> json) {
    return StudentJob(
      id: json['id'] ?? 0,
      job: json['job'] ?? 'Unknown',
      titleMale: json['title_male'] ?? '',
      titleFemale: json['title_female'] ?? '',
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class PaymentMethodAffilate {
  final int id;
  final String method;
  final int minPayout;
  final String? thumbnail;
  final int status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PaymentMethodAffilate({
    required this.id,
    required this.method,
    required this.minPayout,
    required this.thumbnail,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentMethodAffilate.fromJson(Map<String, dynamic> json) {
    return PaymentMethodAffilate(
      id: json['id'] ?? 0,
      method: json['method'] ?? 'Unknown',
      minPayout: json['min_payout'] ?? 0,
      thumbnail: json['thumbnail'],
      status: json['status'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class DataModel {
  final String success;
  final List<Country> countries;
  final List<City> cities;
  final List<Category> categories;
  final List<Education> educations;
  final List<ParentRelation> parentRelations;
  final List<StudentJob> studentJobs;
  final List<PaymentMethodAffilate> paymentMethods;

  DataModel({
    required this.success,
    required this.countries,
    required this.cities,
    required this.categories,
    required this.educations,
    required this.parentRelations,
    required this.studentJobs,
    required this.paymentMethods,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      success: json['success'] ?? '',
      countries: (json['country'] as List)
          .map((countryJson) => Country.fromJson(countryJson))
          .toList(),
      cities: (json['city'] as List)
          .map((cityJson) => City.fromJson(cityJson))
          .toList(),
      categories: (json['category'] as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList(),
      educations: (json['education'] as List)
          .map((educationJson) => Education.fromJson(educationJson))
          .toList(),
      parentRelations: (json['parentRelation'] as List)
          .map((parentRelationJson) =>
              ParentRelation.fromJson(parentRelationJson))
          .toList(),
      studentJobs: (json['studentJobs'] as List)
          .map((studentJobJson) => StudentJob.fromJson(studentJobJson))
          .toList(),
      paymentMethods: (json['paymentMethodAffilate'] as List)
          .map((paymentMethodJson) =>
              PaymentMethodAffilate.fromJson(paymentMethodJson))
          .toList(),
    );
  }
}
