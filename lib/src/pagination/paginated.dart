import 'package:flutter/foundation.dart';

@immutable
class Paginated<T> {
  final int totalItemCount;
  final List<T> items;

  const Paginated({required this.totalItemCount, required this.items});

  @override
  bool operator ==(Object other) =>
      other is Paginated &&
      other.runtimeType == runtimeType &&
      other.totalItemCount == totalItemCount &&
      other.items == items;

  @override
  int get hashCode => Object.hash(totalItemCount, items);

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {'totalItemCount': totalItemCount, 'items': items};
  }

  factory Paginated.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) itemFromJson,
  ) {
    return Paginated(
      totalItemCount: json['totalItemCount'] as int,
      items: (json['items'] as List)
          .map((item) => itemFromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
