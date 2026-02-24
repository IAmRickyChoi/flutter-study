import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  final DateTime createdAt;

  User({required this.name, required this.age}) : createdAt = DateTime.now();
}
