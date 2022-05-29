const String tablePolls = 'polls';

class PollFields {
  static final List<String> values = [
    id, numPersons, year, presidentId, treasurerId, active, cancelled
  ];

  static const String id = '_id';
  static const String numPersons = 'num_persons';
  static const String year = 'year';
  static const String presidentId = 'president_id';
  static const String treasurerId = 'treasurer_id';
  static const String active = 'active';
  static const String cancelled = 'cancelled';
}

class Poll {
  int? id;
  int numPersons;
  int year;
  int presidentId;
  int treasurerId;
  int active;
  int cancelled;

  Poll({
    this.id,
    required this.numPersons,
    required this.year,
    required this.presidentId,
    required this.treasurerId,
    required this.active,
    required this.cancelled,
  });

  Map<String, Object?> toJson() => {
    PollFields.id: id,
    PollFields.numPersons: numPersons,
    PollFields.year: year,
    PollFields.presidentId: presidentId,
    PollFields.treasurerId: treasurerId,
    PollFields.active: active,
    PollFields.cancelled: cancelled,
  };

  static Poll fromJson(Map<String, Object?> json) => Poll(
    id: json[PollFields.id] as int?,
    numPersons: json[PollFields.numPersons] as int,
    year: json[PollFields.year] as int,
    presidentId: json[PollFields.presidentId] as int,
    treasurerId: json[PollFields.treasurerId] as int,
    active: json[PollFields.active] as int,
    cancelled: json[PollFields.cancelled] as int,
  );

  Poll copy({
    int? id,
    int? numPersons,
    int? year,
    int? presidentId,
    int? treasurerId,
    int? active,
    int? cancelled,
  }) => Poll(
    id: id ?? this.id,
    numPersons: numPersons ?? this.numPersons,
    year: year ?? this.year,
    presidentId: presidentId ?? this.presidentId,
    treasurerId: treasurerId ?? this.treasurerId,
    active: active ?? this.active,
    cancelled: cancelled ?? this.cancelled,
  );
}