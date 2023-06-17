import 'package:hive_flutter/hive_flutter.dart';
part 'cart.g.dart';

@HiveType(typeId: 1)
class Cart {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? image;

  @HiveField(2)
  final String? name;

  @HiveField(3)
  final double? price;

  @HiveField(4)
  final String? color;

  @HiveField(5)
  final int? number;

  Cart({this.id, this.image, this.name, this.number, this.price, this.color});
}
