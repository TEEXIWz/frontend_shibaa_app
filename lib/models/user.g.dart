// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..uid = json['uid'] as num
  ..name = json['name'] as String
  ..username = json['username'] as String
  ..password = json['password'] as String
  ..description = json['description'] as String
  ..img = json['img'] as String
  ..follower = json['follower'] as num
  ..following = json['following'] as num;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'username': instance.username,
      'password': instance.password,
      'description': instance.description,
      'img': instance.img,
      'follower': instance.follower,
      'following': instance.following,
    };
