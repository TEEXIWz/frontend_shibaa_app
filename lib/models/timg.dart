import 'package:json_annotation/json_annotation.dart';

part 'timg.g.dart';

@JsonSerializable()
class Timg {
  Timg();

  late num id;
  late String img;
  
  factory Timg.fromJson(Map<String,dynamic> json) => _$TimgFromJson(json);
  Map<String, dynamic> toJson() => _$TimgToJson(this);
}
