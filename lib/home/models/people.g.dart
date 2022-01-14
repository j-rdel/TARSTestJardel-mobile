// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

People _$PeopleFromJson(Map<String, dynamic> json) {
  return People()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..age = json['age'] as int
    ..career = json['career'] as String
    ..photourl = json['photourl'] as String;
}

Map<String, dynamic> _$PeopleToJson(People instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'career': instance.career,
      'photourl': instance.photourl,
    };
