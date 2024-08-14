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
      id: json['id'] ?? 0, // Provide default values in case of null
      name: json['name'] ?? 'Unknown', // Default value
      status: json['status'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ??
          DateTime.now().toIso8601String()), // Default to current date/time
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

  ParentRelation({
    required this.id,
    required this.name,
  });

  factory ParentRelation.fromJson(Map<String, dynamic> json) {
    return ParentRelation(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
    );
  }
}

class DataModel {
  final List<Country> countries;
  final List<City> cities;
  final List<Category> categories;
  final List<Education> educations;
  final List<ParentRelation> parentRelations;

  DataModel({
    required this.countries,
    required this.cities,
    required this.categories,
    required this.educations,
    required this.parentRelations,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      countries: (json['country'] as List?)
              ?.map((country) =>
                  Country.fromJson(country as Map<String, dynamic>))
              .toList() ??
          [],
      cities: (json['city'] as List?)
              ?.map((city) => City.fromJson(city as Map<String, dynamic>))
              .toList() ??
          [],
      categories: (json['category'] as List?)
              ?.map((category) =>
                  Category.fromJson(category as Map<String, dynamic>))
              .toList() ??
          [],
      educations: (json['education'] as List?)
              ?.map((education) =>
                  Education.fromJson(education as Map<String, dynamic>))
              .toList() ??
          [],
      parentRelations: (json['parentRelation'] as List?)
              ?.map((parentRelation) => ParentRelation.fromJson(
                  parentRelation as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
