const String tablePersonTypes = 'person_types';

class PersonTypeFields {
  static final List<String> values = [
    // Add all fields
    id, type, description
  ];

  static const String id = '_id';
  static const String type = 'type';
  static const String description = 'description';
}

class PersonType {
  int? id;
  String type;
  String description;

  PersonType({
    this.id,
    required this.type,
    required this.description,
  });

  Map<String, Object?> toJson() => {
    PersonTypeFields.id: id,
    PersonTypeFields.type: type,
    PersonTypeFields.description: description,
  };

  static PersonType fromJson(Map<String, Object?> json) => PersonType(
    id: json[PersonTypeFields.id] as int?,
    type: json[PersonTypeFields.type] as String,
    description: json[PersonTypeFields.description] as String,
  );

  PersonType copy({
    int? id,
    String? type,
    String? description
  }) => PersonType(
    id: id ?? this.id,
    type: type ?? this.type,
    description: description ?? this.description,
  );
}