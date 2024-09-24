class BonusResponse {
  String success;
  AffiliateBonus affiliateBonus;
  int bundlePaid;
  List<TotalBonus> bonus;

  BonusResponse({
    required this.success,
    required this.affiliateBonus,
    required this.bundlePaid,
    required this.bonus,
  });

  factory BonusResponse.fromJson(Map<String, dynamic> json) {
    return BonusResponse(
      success: json['success'] ?? '',
      affiliateBonus: AffiliateBonus.fromJson(json['affiliate_bonus'] ?? {}),
      bundlePaid: json['bundle_paid'] ?? 0,
      bonus: (json['bonus'] as List<dynamic>?)
              ?.map((item) => TotalBonus.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'affiliate_bonus': affiliateBonus.toJson(),
      'bundle_paid': bundlePaid,
      'bonus': bonus.map((item) => item.toJson()).toList(),
    };
  }
}

class AffiliateBonus {
  int id;
  String title;
  int target;
  String bonus;
  String? image;
  String createdAt;
  String updatedAt;
  Pivot pivot;

  AffiliateBonus({
    required this.id,
    required this.title,
    required this.target,
    required this.bonus,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory AffiliateBonus.fromJson(Map<String, dynamic> json) {
    return AffiliateBonus(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      target: json['target'] ?? 0,
      bonus: json['bonus'] ?? '',
      image: json['image'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      pivot: Pivot.fromJson(json['pivot'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'target': target,
      'bonus': bonus,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pivot': pivot.toJson(),
    };
  }
}

class TotalBonus {
  int id;
  String title;
  int target;
  String bonus;
  String? image;
  String createdAt;
  String updatedAt;

  TotalBonus({
    required this.id,
    required this.title,
    required this.target,
    required this.bonus,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TotalBonus.fromJson(Map<String, dynamic> json) {
    return TotalBonus(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      target: json['target'] ?? 0,
      bonus: json['bonus'] ?? '',
      image: json['image'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'target': target,
      'bonus': bonus,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Pivot {
  int affiliateId;
  int bonusId;

  Pivot({
    required this.affiliateId,
    required this.bonusId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      affiliateId: json['affilate_id'] ?? 0,
      bonusId: json['bonus_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'affilate_id': affiliateId,
      'bonus_id': bonusId,
    };
  }
}
