import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  Post();

  late num id;
  late String name;
  late String title;
  late String description;
  late num liked;
  late String created_at;
  late String img;
  late String uimg;
  
  factory Post.fromJson(Map<String,dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
