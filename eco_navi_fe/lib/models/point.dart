class Point {
  final int memberId;
  final int amount;
  final String updatedAt;

  Point({
    required this.memberId,
    required this.amount,
    required this.updatedAt,
  });

  factory Point.fromJson(Map<String, dynamic> json) => Point(
    memberId: json['memberId'] as int,
    amount: json['amount'] as int,
    updatedAt: json['updatedAt'] as String,
  );

  /// Model → JSON (필요할 때만)
  Map<String, dynamic> toJson() => {
    'memberId': memberId,
    'amount': amount,
    'updatet': updatedAt,
  };
}
