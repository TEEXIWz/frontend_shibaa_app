// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timgs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timgs _$TimgsFromJson(Map<String, dynamic> json) => Timgs()
  ..timgs = (json['timgs'] as List<dynamic>)
      .map((e) => Timg.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$TimgsToJson(Timgs instance) => <String, dynamic>{
      'timgs': instance.timgs,
    };
