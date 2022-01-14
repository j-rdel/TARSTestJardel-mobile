import 'package:json_annotation/json_annotation.dart';
import 'package:tarstest/home/models/people.dart';

part 'list_people_response.g.dart';

@JsonSerializable()
class ListPeopleResponse {
  ListPeopleResponse();

  @JsonKey(ignore: true)
  late List<People> peoples;

  factory ListPeopleResponse.fromJson(Map<String, dynamic> json) =>
      _$ListPeopleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListPeopleResponseToJson(this);
}
