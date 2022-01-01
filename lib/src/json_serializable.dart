import 'dart:convert';
import 'dart:mirrors';

///This class provides a Json Serializable mechanism,
///you can use it with any class that you want a basic
///behaviour to generate Map or Json and desired class
///from Map or Json.
///
///#### How to use it (keep sure your constructor uses named parameters):
///
///```dart
///class User with JsonSerializable {
///  final int id;
///  final String name;
///  final int age;
///
///  User({required this.id, required this.name, required this.age});
///}
///```
///
///Then you should be able to use the following methods: `toMap`, `toJson`,
///`fromMap`, `fromJson`
///
///### Full example
///```dart
///import 'package:json_serializable/json_serializable.dart';
///
///import 'models/user_model.dart';
///
///void exampleWithMap() {
///  var commonUser = User(id: 1, name: "Dash", age: 10);
///
///  print(commonUser.toMap());
///
///  var parsedUser = JsonSerializable.fromMap<User>(commonUser.toMap());
///
///  print(parsedUser.toMap());
///}
///
///void exampleWithJson() {
///  var commonUser = User(id: 1, name: "Dash", age: 10);
///
///  print(commonUser.toJson());
///
///  var parsedUser = JsonSerializable.fromJson<User>(commonUser.toJson());
///
///  print(parsedUser.toJson());
///}
///
///void main() {
///  try {
///    exampleWithMap();
///    exampleWithJson();
///  } catch (e) {
///    print(e);
///  }
///}
///```
///
abstract class JsonSerializable {
  Map<String, dynamic> toMap({List<String> excludes = const []}) {
    InstanceMirror im = reflect(this);
    ClassMirror cm = im.type;

    Map<String, dynamic> map = {};

    cm.declarations.values.whereType<VariableMirror>().forEach((vm) {
      final key = MirrorSystem.getName(vm.simpleName);
      final value = im.getField(vm.simpleName).reflectee;

      if (!(excludes.indexWhere((field) => field == key) > -1)) {
        map[key] = value;
      }
    });

    return map;
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static B fromMap<B extends Object>(Map<String, dynamic> source,
      {List<String> excludes = const []}) {
    ClassMirror cm = reflectClass(B);

    Map<Symbol, dynamic> args = {};

    for (var i in source.entries) {
      if (!(excludes.indexWhere((field) => field == i.key) > -1)) {
        args[Symbol(i.key)] = i.value;
      }
    }

    InstanceMirror im = cm.newInstance(Symbol(''), [], args);
    var o = im.reflectee;

    return o;
  }

  static B fromJson<B extends Object>(String source) =>
      fromMap<B>(jsonDecode(source));
}
