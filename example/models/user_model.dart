import 'package:json_serializable/json_serializable.dart';

class User with JsonSerializable {
  final int id;
  final String name;
  final int age;

  User({required this.id, required this.name, required this.age});
}
