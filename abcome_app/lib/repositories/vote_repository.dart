import 'package:abcome_app/database/abcome_database.dart';
import 'package:abcome_app/models/vote.dart';

class VoteRepository {

  // Método que devolve o voto de uma pessoa e de uma votação
  static Future<Vote?> readByPersonPoll(int idPerson, int idPoll) async {
    final db = await ABComeDatabase.instance.database;

    final maps = await db!.query(
      tableVotes,
      columns: VoteFields.values,
      where: '${VoteFields.id} = ? AND ${VoteFields.pollId} = ?',
      whereArgs: [idPerson, idPoll],
    );

    if (maps.isNotEmpty) {
      return Vote.fromJson(maps.first);
    } else {
      return null;
    }
  }

  // Método que cria um voto
  static Future<Vote> insert(Vote vote) async {
    final db = await ABComeDatabase.instance.database;

    final id = await db!.insert(tableVotes, vote.toJson());
    return vote.copy(id: id);
  }
}