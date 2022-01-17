class PersonModel {
  PersonModel({
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

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        career: json['career'],
        photoURL: json['photoURL'],
      );
}
