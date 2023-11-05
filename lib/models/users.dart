import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'users.g.dart';

@JsonSerializable()
class Users {
  Users();

  late List<User> users;
  
  factory Users.fromJson(Map<String,dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);

  static Users filterList(Users users, String filterString) {
    Users tempUsers = users;
    List<User> usersList = tempUsers.users
        .where((u) =>
            (u.name.toLowerCase().contains(filterString.toLowerCase())) ||
            (u.username.toLowerCase().contains(filterString.toLowerCase())))
        .toList();
    users.users = usersList;
    return users;
  }
}
