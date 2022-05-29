const String tablePersons = 'persons';

class PersonFields {
  static final List<String> values = [
    id, name, image, inactive
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String image = 'image';
  static const String inactive = 'inactive';
}

class Person {
  int? id;
  String name;
  String image;
  int inactive;

  Person({
    this.id,
    required this.name,
    required this.image,
    required this.inactive,
  });

  Map<String, Object?> toJson() => {
    PersonFields.id: id,
    PersonFields.name: name,
    PersonFields.image: image,
    PersonFields.inactive: inactive,
  };

  static Person fromJson(Map<String, Object?> json) => Person(
    id: json[PersonFields.id] as int?,
    name: json[PersonFields.name] as String,
    image: json[PersonFields.image] as String,
    inactive: json[PersonFields.inactive] as int,
  );

  Person copy({
    int? id,
    String? name,
    String? image,
    int? inactive,
  }) => Person(
    id: id ?? this.id,
    name: name ?? this.name,
    image: image ?? this.image,
    inactive: inactive ?? this.inactive,
  );
}