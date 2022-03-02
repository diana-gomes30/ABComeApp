const String tableSettings = 'settings';

class SettingFields {
  static final List<String> values = [
    // Add all fields
    id, fkSettingPerson, fkSettingPersonType, year, personLimit
  ];

  static const String id = '_id';
  static const String fkSettingPerson = 'fk_setting_person';
  static const String fkSettingPersonType = 'fk_setting_person_type';
  static const String year = 'year';
  static const String personLimit = 'person_limit';
}

class Setting {
  int? id;
  String fkSettingPerson;
  String fkSettingPersonType;
  int year;
  int personLimit;

  Setting({
    this.id,
    required this.fkSettingPerson,
    required this.fkSettingPersonType,
    required this.year,
    required this.personLimit,
  });

  Map<String, Object?> toJson() => {
    SettingFields.id: id,
    SettingFields.fkSettingPerson: fkSettingPerson,
    SettingFields.fkSettingPersonType: fkSettingPersonType,
    SettingFields.year: year,
    SettingFields.personLimit: personLimit,
  };

  static Setting fromJson(Map<String, Object?> json) => Setting(
    id: json[SettingFields.id] as int?,
    fkSettingPerson: json[SettingFields.fkSettingPerson] as String,
    fkSettingPersonType: json[SettingFields.fkSettingPersonType] as String,
    year: json[SettingFields.year] as int,
    personLimit: json[SettingFields.personLimit] as int,
  );

  Setting copy({
    int? id,
    String? fkSettingPerson,
    String? fkSettingPersonType,
    int? year,
    int? personLimit
  }) => Setting(
    id: id ?? this.id,
    fkSettingPerson: fkSettingPerson ?? this.fkSettingPerson,
    fkSettingPersonType: fkSettingPersonType ?? this.fkSettingPersonType,
    year: year ?? this.year,
    personLimit: personLimit ?? this.personLimit,
  );
}