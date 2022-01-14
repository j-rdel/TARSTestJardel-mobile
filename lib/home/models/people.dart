import 'package:json_annotation/json_annotation.dart';

part 'people.g.dart';

@JsonSerializable()
class People {
  @JsonKey(name: "id")
  late int id;

  @JsonKey(name: "name")
  late String name;

  @JsonKey(name: "age")
  late int age;

  @JsonKey(name: "career")
  late String career;

  @JsonKey(name: "photourl")
  late String photourl;

  People();

  factory People.fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);
  Map<String, dynamic> toJson() => _$PeopleToJson(this);
}
