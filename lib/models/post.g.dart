// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post()
  ..id = json['id'] as num
  ..uid = json['uid'] as num
  ..name = json['name'] as String
  ..title = json['title'] as String
  ..description = json['description'] as String
  ..liked = json['liked'] as num
  ..created_at = json['created_at'] as String
  ..img = json['img'] as String
  ..uimg = json['uimg'] as String;

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'name': instance.name,
      'title': instance.title,
      'description': instance.description,
      'liked': instance.liked,
      'created_at': instance.created_at,
      'img': instance.img,
      'uimg': instance.uimg,
    };
