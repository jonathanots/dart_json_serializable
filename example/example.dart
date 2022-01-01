import 'package:json_serializable/json_serializable.dart';

import 'models/user_model.dart';

void exampleWithMap() {
  var commonUser = User(id: 1, name: "Dash", age: 10);

  print(commonUser.toMap());

  var parsedUser = JsonSerializable.fromMap<User>(commonUser.toMap());

  print(parsedUser.toMap());
}

void exampleWithJson() {
  var commonUser = User(id: 1, name: "Dash", age: 10);

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
