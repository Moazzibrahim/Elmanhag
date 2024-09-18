class PaymentMethodstudent {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String thumbnailLink;

  PaymentMethodstudent({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.thumbnailLink,
  });

  // Factory method to create a PaymentMethod instance from JSON
  factory PaymentMethodstudent.fromJson(Map<String, dynamic> json) {
    return PaymentMethodstudent(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      thumbnailLink: json['thumbnail_link'],
    );
  }

  // Method to convert a PaymentMethod instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'thumbnail_link': thumbnailLink,
    };
  }
}

// Model class for the API response
class PaymentMethodsResponse {
  final List<PaymentMethodstudent> paymentMethods;

  PaymentMethodsResponse({required this.paymentMethods});

  // Factory method to create a PaymentMethodsResponse instance from JSON
  factory PaymentMethodsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['payment_methods'] as List;
    List<PaymentMethodstudent> paymentMethodsList = list.map((i) => PaymentMethodstudent.fromJson(i)).toList();
    return PaymentMethodsResponse(
      paymentMethods: paymentMethodsList,
    );
  }

  // Method to convert a PaymentMethodsResponse instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'payment_methods': paymentMethods.map((e) => e.toJson()).toList(),
    };
  }
}