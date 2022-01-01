import 'package:json_serializable_generic/json_serializable_generic.dart';

class User with JsonSerializable {
  final int id;
  final String name;
  final int age;

  User({required this.id, required this.name, required this.age});
}
