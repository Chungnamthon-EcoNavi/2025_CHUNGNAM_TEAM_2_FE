class BookMark {
  final int id;
  final int memberId;
  final int placeId;

  BookMark({required this.id, required this.memberId, required this.placeId});

  factory BookMark.fromJson(Map<String, dynamic> json) => BookMark(
    id: json['id'] as int,
    memberId: json['memberId'] as int,
    placeId: json['placeId'] as int,
  );

  /// Model → JSON (필요할 때만)
  Map<String, dynamic> toJson() => {
    'id': id,
    'memberId': memberId,
    'placeId': placeId,
  };
}
