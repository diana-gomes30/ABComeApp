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

  // Método que devolve todos os votos
  static Future<List<Vote>> readAll() async {
    final db = await ABComeDatabase.instance.database;

    final result = await db!.query(
      tableVotes,
      orderBy: '${VoteFields.id} ASC',
    );

    return result.map((json) => Vote.fromJson(json)).toList();
  }

  // Método que devolve todos os votos por votação
  static Future<List<Vote>> readAllByPoll(int idPoll) async {
    final db = await ABComeDatabase.instance.database;

    final result = await db!.query(
      tableVotes,
      where: '${VoteFields.pollId} = ?',
      whereArgs: [idPoll],
      orderBy: '${VoteFields.pollId}, ${VoteFields.personId} ASC',
    );

    return result.map((json) => Vote.fromJson(json)).toList();
  }

  // Método que cria um voto
  static Future<Vote> insert(Vote vote) async {
    final db = await ABComeDatabase.instance.database;

    final id = await db!.insert(tableVotes, vote.toJson());
    return vote.copy(id: id);
  }

  // Método que atualiza um voto existente
  static Future<Vote> update(Vote vote) async {
    final db = await ABComeDatabase.instance.database;

    await db!.update(
      tableVotes,
      vote.toJson(),
      where: '${VoteFields.id} = ?',
      whereArgs: [vote.id],
    );

    return vote.copy(id: vote.id);
  }

  static Future<void> deleteByPoll(int idPoll) async {
    final db = await ABComeDatabase.instance.database;

    await db!.delete(
      tableVotes,
      where: '${VoteFields.pollId} = ?',
      whereArgs: [idPoll],
    );
  }
}