class Country {
  int id;
  String name;
  String status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Country({
    required this.id,
    required this.name,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
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
      'name': name,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class City {
  int id;
  String name;
  int countryId;
  String status;
  DateTime? createdAt;
  DateTime? updatedAt;

  City({
    required this.id,
    required this.name,
    required this.countryId,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      countryId: json['country_id'],
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
      'name': name,
      'country_id': countryId,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class Category {
  int id;
  String name;
  int categoryId;
  String status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
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
      'name': name,
      'category_id': categoryId,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class DataModel {
  List<Country> countries;
  List<City> cities;
  List<Category> categories;

  DataModel({
    required this.countries,
    required this.cities,
    required this.categories,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      countries:
          List<Country>.from(json['countries'].map((x) => Country.fromJson(x))),
      cities: List<City>.from(json['cities'].map((x) => City.fromJson(x))),
      categories: List<Category>.from(
          json['categories'].map((x) => Category.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countries': List<dynamic>.from(countries.map((x) => x.toJson())),
      'cities': List<dynamic>.from(cities.map((x) => x.toJson())),
      'categories': List<dynamic>.from(categories.map((x) => x.toJson())),
    };
  }
}
