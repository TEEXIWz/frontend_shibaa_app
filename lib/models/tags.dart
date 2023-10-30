import 'package:json_annotation/json_annotation.dart';
import "tag.dart";
part 'tags.g.dart';

@JsonSerializable()
class Tags {
  Tags();

  late List<Tag> tags;
  
  factory Tags.fromJson(Map<String,dynamic> json) => _$TagsFromJson(json);
  Map<String, dynamic> toJson() => _$TagsToJson(this);
}
