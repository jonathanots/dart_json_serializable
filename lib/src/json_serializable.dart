import 'dart:convert';
import 'dart:mirrors';

///This class provides a Json Serializable mecanism,
///you can use it with any class that you want a basic
///behaviour to generate Map or Json and desired class
///from Map or Json.
///
///To use it (keep sure your constructor uses named parameters):
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