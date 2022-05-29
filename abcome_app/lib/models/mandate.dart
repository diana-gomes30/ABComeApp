const String tableMandates = 'mandates';

class MandateFields {
  static final List<String> values = [
    id, personLimit, presidentId, treasurerId, active, pollId
  ];

  static const String id = '_id';
  static const String personLimit = 'person_limit';
  static const String presidentId = 'president_id';
  static const String treasurerId = 'treasurer_id';
  static const String active = 'active';
  static const String pollId = 'poll_id';
}

class Mandate {
  int? id;
  int personLimit;
  int presidentId;
  int treasurerId;
  int active;
  int pollId;

  Mandate({
    this.id,
    required this.personLimit,
    required this.presidentId,
    required this.treasurerId,
    required this.active,
    required this.pollId,
  });

  Map<String, Object?> toJson() => {
    MandateFields.id: id,
    MandateFields.personLimit: personLimit,
    MandateFields.presidentId: presidentId,
    MandateFields.treasurerId: treasurerId,
    MandateFields.active: active,
    MandateFields.pollId: pollId,
  };

  static Mandate fromJson(Map<String, Object?> json) => Mandate(
    id: json[MandateFields.id] as int?,
    personLimit: json[MandateFields.personLimit] as int,
    presidentId: json[MandateFields.presidentId] as int,
    treasurerId: json[MandateFields.treasurerId] as int,
    active: json[MandateFields.active] as int,
    pollId: json[MandateFields.pollId] as int,
  );

  Mandate copy({
    int? id,
    int? personLimit,
    int? presidentId,
    int? treasurerId,
    int? active,
    int? pollId,
  }) => Mandate(
    id: id ?? this.id,
    personLimit: personLimit ?? this.personLimit,
    presidentId: presidentId ?? this.presidentId,
    treasurerId: treasurerId ?? this.treasurerId,
    active: active ?? this.active,
    pollId: pollId ?? this.pollId,
  );
}