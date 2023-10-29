// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post()
  ..id = json['id'] as num
  ..username = json['username'] as String
  ..description = json['description'] as String
  ..liked = json['liked'] as num
  ..date = json['date'] as String
  ..time = json['time'] as String
  ..img = json['img'] as String
  ..uimg = json['uimg'] as String;

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'description': instance.description,
      'liked': instance.liked,
      'date': instance.date,
      'time': instance.time,
      'img': instance.img,
      'uimg': instance.uimg,
    };
