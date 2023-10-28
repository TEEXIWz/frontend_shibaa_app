import 'package:json_annotation/json_annotation.dart';
import "timg.dart";
part 'timgs.g.dart';

@JsonSerializable()
class Timgs {
  Timgs();

  late List<Timg> timgs;
  
  factory Timgs.fromJson(Map<String,dynamic> json) => _$TimgsFromJson(json);
  Map<String, dynamic> toJson() => _$TimgsToJson(this);
}
