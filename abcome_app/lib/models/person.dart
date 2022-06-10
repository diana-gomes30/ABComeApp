const String tablePersons = 'persons';

class PersonFields {
  static final List<String> values = [
    id, name, image, isVoting, inactive
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String image = 'image';
  static const String isVoting = 'is_voting';
  static const String inactive = 'inactive';
}

class Person {
  int? id;
  String name;
  String image;
  int isVoting;
  int inactive;

  Person({
    this.id,
    required this.name,
    required this.image,
    required this.isVoting,
    required this.inactive,
  });

  Map<String, Object?> toJson() => {
    PersonFields.id: id,
    PersonFields.name: name,
    PersonFields.image: image,
    PersonFields.isVoting: isVoting,
    PersonFields.inactive: inactive,
  };

  static Person fromJson(Map<String, Object?> json) => Person(
    id: json[PersonFields.id] as int?,
    name: json[PersonFields.name] as String,
    image: json[PersonFields.image] as String,
    isVoting: json[PersonFields.isVoting] as int,
    inactive: json[PersonFields.inactive] as int,
  );

  Person copy({
    int? id,
    String? name,
    String? image,
    int? isVoting,
    int? inactive,
  }) => Person(
    id: id ?? this.id,
    name: name ?? this.name,
    image: image ?? this.image,
    isVoting: isVoting ?? this.isVoting,
    inactive: inactive ?? this.inactive,
  );
}