const String tableVotes = 'votes';

class VoteFields {
  static final List<String> values = [
    id, personId, pollId, presidentId, treasurerId
  ];

  static const String id = '_id';
  static const String personId = 'person_id';
  static const String pollId = 'poll_id';
  static const String presidentId = 'president_id';
  static const String treasurerId = 'treasurer_id';
}


class Vote {
  int? id;
  int personId;
  int pollId;
  int presidentId;
  int treasurerId;

  Vote({
    this.id,
    required this.personId,
    required this.pollId,
    required this.presidentId,
    required this.treasurerId,
  });

  Map<String, Object?> toJson() => {
    VoteFields.id: id,
    VoteFields.personId: personId,
    VoteFields.pollId: pollId,
    VoteFields.presidentId: presidentId,
    VoteFields.treasurerId: treasurerId,
  };

  static Vote fromJson(Map<String, Object?> json) => Vote(
    id: json[VoteFields.id] as int?,
    personId: json[VoteFields.personId] as int,
    pollId: json[VoteFields.pollId] as int,
    presidentId: json[VoteFields.presidentId] as int,
    treasurerId: json[VoteFields.treasurerId] as int,
  );

  Vote copy({
    int? id,
    int? personId,
    int? pollId,
    int? presidentId,
    int? treasurerId,
  }) => Vote(
    id: id ?? this.id,
    personId: personId ?? this.personId,
    pollId: pollId ?? this.pollId,
    presidentId: presidentId ?? this.presidentId,
    treasurerId: treasurerId ?? this.treasurerId,
  );
}