const String tableStatistics = 'statistics';

class StatisticFields {
  static final List<String> values = [
    id, personId, year, pollId, presidentNumVotes, treasurerNumVotes
  ];

  static const String id = '_id';
  static const String personId = 'person_id';
  static const String year = 'year';
  static const String pollId = 'poll_id';
  static const String presidentNumVotes = 'president_num_votes';
  static const String treasurerNumVotes = 'treasurer_num_votes';
}

class Statistic {
  int? id;
  int personId;
  int year;
  int pollId;
  int presidentNumVotes;
  int treasurerNumVotes;

  Statistic({
    this.id,
    required this.personId,
    required this.year,
    required this.pollId,
    required this.presidentNumVotes,
    required this.treasurerNumVotes,
  });

  Map<String, Object?> toJson() => {
    StatisticFields.id: id,
    StatisticFields.personId: personId,
    StatisticFields.year: year,
    StatisticFields.pollId: pollId,
    StatisticFields.presidentNumVotes: presidentNumVotes,
    StatisticFields.treasurerNumVotes: treasurerNumVotes,
  };

  static Statistic fromJson(Map<String, Object?> json) => Statistic(
    id: json[StatisticFields.id] as int?,
    personId: json[StatisticFields.personId] as int,
    year: json[StatisticFields.year] as int,
    pollId: json[StatisticFields.pollId] as int,
    presidentNumVotes: json[StatisticFields.presidentNumVotes] as int,
    treasurerNumVotes: json[StatisticFields.treasurerNumVotes] as int,
  );

  Statistic copy({
    int? id,
    int? personId,
    int? year,
    int? pollId,
    int? presidentNumVotes,
    int? treasurerNumVotes,
  }) => Statistic(
    id: id ?? this.id,
    personId: personId ?? this.personId,
    year: year ?? this.year,
    pollId: pollId ?? this.pollId,
    presidentNumVotes: presidentNumVotes ?? this.presidentNumVotes,
    treasurerNumVotes: treasurerNumVotes ?? this.treasurerNumVotes,
  );
}