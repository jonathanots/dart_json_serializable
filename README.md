## json_serializable
--- 

This package provides a Json Serializable mechanism.
You can add this behavior to any class you like.

### Getting Started:
---

```dart
class User with JsonSerializable {
  final int id;
  final String name;
  final int age;

  User({required this.id, required this.name, required this.age});
}
```

At first you need to create a new class or use an existing, then
add the mixin JsonSerializable like the code above. 
**Make sure thar your constructor uses named parameters**.


After your added the JsonSerializable to an Class you can will see
the following new methods

- toMap - use it if you want to convert your current instance to a Map structure
- toJson - use it if you want to convert your current instance to a json encoded data
- fromMap - use it if you want to convert a Map structure into a Class. **Make sure that your constructor uses named parameters** 
- fromJson - use it if you want to convert a json encoded data into a class. **Make sure that your constructor uses named parameters** 

To import `json_serializable`:

```dart
import 'package:json_serializable/json_serializable.dart';
```

### Full example:
---

```dart
import 'package:json_serializable/json_serializable.dart';

import 'models/user_model.dart';

void exampleWithMap() {
  var commonUser = User(id: 1, name: 'Dash', age: 10);

  print(commonUser.toMap());

  var parsedUser = JsonSerializable.fromMap<User>(commonUser.toMap());

  print(parsedUser.toMap());
}

void exampleWithJson() {
  var commonUser = User(id: 1, name: 'Dash', age: 10);

  print(commonUser.toJson());

  var parsedUser = JsonSerializable.fromJson<User>(commonUser.toJson());

  print(parsedUser.toJson());
}

void main() {
  try {
    exampleWithMap();
    exampleWithJson();
  } catch (e) {
    print(e);
  }
}

```

## Extras

- Now you can use a optional parameter on toMap and fromMap methods, if your want to exclude some variable when convert a class to Map send a ```List<String>```, and the same idea can be used when you want to create a instance of an class from Map data but not want some fields because them not used on your constructor.

To use excludes key whe using `toMap` method:

```dart
var user = User(id: 1, name: 'Dash', age: 10);

print(user.toMap(excludes: ['id']));

//{name: Dash, age: 10}
```

To use excludes key when trying parse `Map` data into a `instance` of an class:

```dart
var mapUser = {
  "id": 2,
  "name": "foo",
  "lastName": "bar",
  "age": 11,
};

var user = 
  JsonSerializable.fromMap<User>(mapUser, excludes:['lastName']);

print(user.toMap());

//{id: 2, name: foo, age: 11}
```