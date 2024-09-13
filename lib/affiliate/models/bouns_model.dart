class BonusResponse {
  String success;
  AffiliateBonus affiliateBonus;

  BonusResponse({
    required this.success,
    required this.affiliateBonus,
  });

  factory BonusResponse.fromJson(Map<String, dynamic> json) {
    return BonusResponse(
      success: json['success'],
      affiliateBonus: AffiliateBonus.fromJson(json['affiliate_bonus']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'affiliate_bonus': affiliateBonus.toJson(),
    };
  }
}

class AffiliateBonus {
  int id;
  String title;
  int target;
  String bonus;
  String image;
  String createdAt;
  String updatedAt;
  int bundlePaid;
  List<TotalBonus> totalBonus;
  Pivot pivot;

  AffiliateBonus({
    required this.id,
    required this.title,
    required this.target,
    required this.bonus,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.bundlePaid,
    required this.totalBonus,
    required this.pivot,
  });

  factory AffiliateBonus.fromJson(Map<String, dynamic> json) {
    return AffiliateBonus(
      id: json['id'],
      title: json['title'],
      target: json['target'],
      bonus: json['bonus'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      bundlePaid: json['bundle_paid'],
      totalBonus: List<TotalBonus>.from(
          json['total_bonus'].map((item) => TotalBonus.fromJson(item))),
      pivot: Pivot.fromJson(json['pivot']),
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
      'bundle_paid': bundlePaid,
      'total_bonus': totalBonus.map((item) => item.toJson()).toList(),
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
      id: json['id'],
      title: json['title'],
      target: json['target'],
      bonus: json['bonus'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
      affiliateId: json['affilate_id'],
      bonusId: json['bonus_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'affilate_id': affiliateId,
      'bonus_id': bonusId,
    };
  }
}
