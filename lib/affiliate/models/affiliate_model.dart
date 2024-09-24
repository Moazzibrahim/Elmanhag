class AffiliateData {
  final String success;
  final int totalPayout;
  final User user;

  AffiliateData({
    required this.success,
    required this.totalPayout,
    required this.user,
  });

  factory AffiliateData.fromJson(Map<String, dynamic> json) {
    return AffiliateData(
      success: json['success'] ?? '',
      totalPayout: json['total_payout'] ?? 0,
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'total_payout': totalPayout,
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
  final String gender;
  final String email;
  final String? emailVerifiedAt;
  final int? parentRelationId;
  final int? categoryId;
  final int countryId;
  final int cityId;
  final int? parentId;
  final int? educationId;
  final int? studentJobsId;
  final int? affiliateId;
  final String? affilateCode; // Updated field name
  final int status;
  final String? adminPositionId;
  final String createdAt;
  final String updatedAt;
  final String imageLink;
  final Income income;
  final List<PayoutHistory> payoutHistory;
  final List<AffiliateHistory> affiliateHistory;
  final int studentSignups; // New field

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.image,
    required this.role,
    required this.gender,
    required this.email,
    this.emailVerifiedAt,
    this.parentRelationId,
    this.categoryId,
    required this.countryId,
    required this.cityId,
    this.parentId,
    this.educationId,
    this.studentJobsId,
    this.affiliateId,
    this.affilateCode, // Updated field name
    required this.status,
    this.adminPositionId,
    required this.createdAt,
    required this.updatedAt,
    required this.imageLink,
    required this.income,
    required this.payoutHistory,
    required this.affiliateHistory,
    required this.studentSignups, // New field
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var payoutList = json['payout_history'] as List? ?? [];
    var affiliateHistoryList = json['affiliate_history'] as List? ?? [];

    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
      role: json['role'] ?? '',
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      parentRelationId: json['parent_relation_id'],
      categoryId: json['category_id'],
      countryId: json['country_id'] ?? 0,
      cityId: json['city_id'] ?? 0,
      parentId: json['parent_id'],
      educationId: json['education_id'],
      studentJobsId: json['student_jobs_id'],
      affiliateId: json['affiliate_id'],
      affilateCode: json['affilate_code'] ?? '', // Updated field name
      status: json['status'] ?? 0,
      adminPositionId: json['admin_position_id'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      imageLink: json['image_link'] ?? '',
      income: Income.fromJson(json['income'] ?? {}),
      payoutHistory: payoutList.map((p) => PayoutHistory.fromJson(p)).toList(),
      affiliateHistory: affiliateHistoryList
          .map((a) => AffiliateHistory.fromJson(a))
          .toList(),
      studentSignups: json['student_signups'] ?? 2, // New field
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
      'student_jobs_id': studentJobsId,
      'affiliate_id': affiliateId,
      'affilate_code': affilateCode, // Updated field name
      'status': status,
      'admin_position_id': adminPositionId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image_link': imageLink,
      'income': income.toJson(),
      'payout_history': payoutHistory.map((p) => p.toJson()).toList(),
      'affiliate_history': affiliateHistory.map((a) => a.toJson()).toList(),
      'student_signups': studentSignups, // New field
    };
  }
}

class Income {
  final int id;
  final double income;
  final double wallet;
  final int affiliateId;
  final String createdAt;
  final String updatedAt;

  Income({
    required this.id,
    required this.income,
    required this.wallet,
    required this.affiliateId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      id: json['id'] ?? 0,
      income: (json['income'] is int)
          ? (json['income'] as int).toDouble()
          : json['income'] ?? 0.0,
      wallet: (json['wallet'] is int)
          ? (json['wallet'] as int).toDouble()
          : json['wallet'] ?? 0.0,
      affiliateId: json['affiliate_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'income': income,
      'wallet': wallet,
      'affiliate_id': affiliateId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class PayoutHistory {
  final int id;
  final String date;
  final int amount;
  final String? description;
  final String? rejectedReason;
  final int status;
  final int affiliateId;
  final int? paymentMethodAffiliateId;
  final String createdAt;
  final String updatedAt;
  final PaymentMethod? method;

  PayoutHistory({
    required this.id,
    required this.date,
    required this.amount,
    this.description,
    this.rejectedReason,
    required this.status,
    required this.affiliateId,
    this.paymentMethodAffiliateId,
    required this.createdAt,
    required this.updatedAt,
    this.method,
  });

  factory PayoutHistory.fromJson(Map<String, dynamic> json) {
    return PayoutHistory(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      amount: json['amount'] ?? 0,
      description: json['description'],
      rejectedReason: json['rejected_reason'],
      status: json['status'] ?? 0,
      affiliateId: json['affiliate_id'] ?? 0,
      paymentMethodAffiliateId: json['payment_method_affiliate_id'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      method: json['method'] != null
          ? PaymentMethod.fromJson(json['method'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'amount': amount,
      'description': description,
      'rejected_reason': rejectedReason,
      'status': status,
      'affiliate_id': affiliateId,
      'payment_method_affiliate_id': paymentMethodAffiliateId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'method': method?.toJson(),
    };
  }
}

class PaymentMethod {
  final int id;
  final String method;
  final int minPayout;
  final String createdAt;
  final String updatedAt;

  PaymentMethod({
    required this.id,
    required this.method,
    required this.minPayout,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'] ?? 0,
      method: json['method'] ?? '',
      minPayout: json['min_payout'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'method': method,
      'min_payout': minPayout,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class AffiliateHistory {
  final int id;
  final String date;
  final String service;
  final String serviceType;
  final double price;
  final double commission;
  final int studentId;
  final int categoryId;
  final int paymentMethodId;
  final int affiliateId;
  final Student student;

  AffiliateHistory({
    required this.id,
    required this.date,
    required this.service,
    required this.serviceType,
    required this.price,
    required this.commission,
    required this.studentId,
    required this.categoryId,
    required this.paymentMethodId,
    required this.affiliateId,
    required this.student,
  });

  factory AffiliateHistory.fromJson(Map<String, dynamic> json) {
    return AffiliateHistory(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      service: json['service'] ?? '',
      serviceType: json['service_type'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      commission: (json['commission'] ?? 0.0).toDouble(),
      studentId: json['student_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      paymentMethodId: json['payment_method_id'] ?? 0,
      affiliateId: json['affiliate_id'] ?? 0,
      student: Student.fromJson(json['student'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'service': service,
      'service_type': serviceType,
      'price': price,
      'commission': commission,
      'student_id': studentId,
      'category_id': categoryId,
      'payment_method_id': paymentMethodId,
      'affiliate_id': affiliateId,
      'student': student.toJson(),
    };
  }
}

class Student {
  final int id;
  final String name;
  final String image;

  Student({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
