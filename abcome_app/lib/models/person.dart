const String tablePersons = 'persons';

class PersonFields {
  static final List<String> values = [
    // Add all fields
    id, name, image
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String image = 'image';
}

class Person {
  int? id;
  String name;
  String image;

  Person({
    this.id,
    required this.name,
    required this.image,
  });

  Map<String, Object?> toJson() => {
    PersonFields.id: id,
    PersonFields.name: name,
    PersonFields.image: image,
  };

  static Person fromJson(Map<String, Object?> json) => Person(
    id: json[PersonFields.id] as int?,
    name: json[PersonFields.name] as String,
    image: json[PersonFields.image] as String,
  );

  Person copy({
    int? id,
    String? name,
    String? image
  }) => Person(
    id: id ?? this.id,
    name: name ?? this.name,
    image: image ?? this.image,
  );
}