class Country {
  final int id;
  final String countryName;
  final DateTime createdAt;
  final DateTime updatedAt;

  Country({
    required this.id,
    required this.countryName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      countryName: json['country_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country_name': countryName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class City {
  final int id;
  final int countryId;
  final String cityName;

  City({
    required this.id,
    required this.countryId,
    required this.cityName,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      countryId: int.parse(json['country']),
      cityName: json['city_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': countryId.toString(),
      'city_name': cityName,
    };
  }
}

class Category {
  final int id;
  final String category;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? parent;

  Category({
    required this.id,
    required this.category,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.parent,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      category: json['category'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      parent: json['parent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'parent': parent,
    };
  }
}

class DataModel {
  final List<Country> countries;
  final List<City> cities;
  final List<Category> categories;

  DataModel({
    required this.countries,
    required this.cities,
    required this.categories,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    var countriesJson = json['countries'] as List;
    var citiesJson = json['cities'] as List;
    var categoriesJson = json['categories'] as List;

    List<Country> countriesList =
        countriesJson.map((i) => Country.fromJson(i)).toList();
    List<City> citiesList = citiesJson.map((i) => City.fromJson(i)).toList();
    List<Category> categoriesList =
        categoriesJson.map((i) => Category.fromJson(i)).toList();

    return DataModel(
      countries: countriesList,
      cities: citiesList,
      categories: categoriesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countries': countries.map((country) => country.toJson()).toList(),
      'cities': cities.map((city) => city.toJson()).toList(),
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }
}
