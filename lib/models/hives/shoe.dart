import 'package:hive_flutter/hive_flutter.dart';
part 'shoe.g.dart';

@HiveType(typeId: 0)
class Shoe {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? image;

  @HiveField(2)
  final String? name;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final double? price;

  @HiveField(5)
  final String? color;

  Shoe({
    this.id,
    this.image,
    this.name,
    this.description,
    this.price,
    this.color,
  });

  factory Shoe.fromJson(Map<String, dynamic> json) {
    return Shoe(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      color: json['color'],
    );
  }
}
