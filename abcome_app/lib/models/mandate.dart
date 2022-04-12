const String tableMandates = 'mandates';

class MandateFields {
  static final List<String> values = [
    // Add all fields
    id, president, treasurer, yearIni, yearFim, personLimit
  ];

  static const String id = '_id';
  static const String president = 'president';
  static const String treasurer = 'treasurer';
  static const String yearIni = 'year_ini';
  static const String yearFim = 'year_fim';
  static const String personLimit = 'person_limit';
}

class Mandate {
  int? id;
  int president;
  int treasurer;
  int yearIni;
  int yearFim;
  int personLimit;

  Mandate({
    this.id,
    required this.president,
    required this.treasurer,
    required this.yearIni,
    required this.yearFim,
    required this.personLimit,
  });

  Map<String, Object?> toJson() => {
    MandateFields.id: id,
    MandateFields.president: president,
    MandateFields.treasurer: treasurer,
    MandateFields.yearIni: yearIni,
    MandateFields.yearFim: yearFim,
    MandateFields.personLimit: personLimit,
  };

  static Mandate fromJson(Map<String, Object?> json) => Mandate(
    id: json[MandateFields.id] as int?,
    president: json[MandateFields.president] as int,
    treasurer: json[MandateFields.treasurer] as int,
    yearIni: json[MandateFields.yearIni] as int,
    yearFim: json[MandateFields.yearFim] as int,
    personLimit: json[MandateFields.personLimit] as int,
  );

  Mandate copy({
    int? id,
    int? president,
    int? treasurer,
    int? yearIni,
    int? yearFim,
    int? personLimit
  }) => Mandate(
    id: id ?? this.id,
    president: president ?? this.president,
    treasurer: treasurer ?? this.treasurer,
    yearIni: yearIni ?? this.yearIni,
    yearFim: yearFim ?? this.yearFim,
    personLimit: personLimit ?? this.personLimit,
  );
}