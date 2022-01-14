class PeopleModel {
  PeopleModel({
    required this.id,
    required this.name,
    required this.age,
    required this.career,
    required this.photoURL,
  });

  final int id;
  final String name;
  final int age;
  final String career;
  final String photoURL;

  factory PeopleModel.fromJson(Map<String, dynamic> json) => PeopleModel(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        career: json['career'],
        photoURL: json['photoURL'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
        "career": career,
        "photoURL": photoURL,
      };
}
