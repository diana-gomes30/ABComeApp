import 'package:abcome_app/database/abcome_database.dart';
import 'package:abcome_app/models/poll.dart';

class PollRepository {

  // Método que devolve a votação por Id
  static Future<Poll?> readById(int id) async {
    final db = await ABComeDatabase.instance.database;

    final maps = await db!.query(
      tablePolls,
      columns: PollFields.values,
      where: '${PollFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Poll.fromJson(maps.first);
    } else {
      return null;
    }
  }

  // Método que devolve a votação ativa por ano
  static Future<Poll?> readActiveByYear(int year) async {
    final db = await ABComeDatabase.instance.database;

    int active = 1;

    final maps = await db!.query(
      tablePolls,
      columns: PollFields.values,
      where: '${PollFields.year} = ? AND ${PollFields.active} = ?',
      whereArgs: [year, active],
    );

    if (maps.isNotEmpty) {
      return Poll.fromJson(maps.first);
    } else {
      return null;
    }
  }

  // Método que devolve a votação em andamento
  static Future<Poll?> readCurrentPoll() async {
    final db = await ABComeDatabase.instance.database;

    int currentYear = DateTime.now().year;
    int active = 1;

    final maps = await db!.query(
      tablePolls,
      columns: PollFields.values,
      where: '${PollFields.year} = ? AND ${PollFields.active} = ?',
      whereArgs: [currentYear, active],
    );

    if (maps.isNotEmpty) {
      return Poll.fromJson(maps.first);
    } else {
      return null;
    }
  }

  // Método que devolve todas as votações
  static Future<List<Poll>> readAll() async {
    final db = await ABComeDatabase.instance.database;

    final result = await db!.query(
        tablePolls,
        orderBy: '${PollFields.id} ASC',
    );

    return result.map((json) => Poll.fromJson(json)).toList();
  }

  // Método que cria uma votação
  static Future<Poll> insert(Poll poll) async {
    final db = await ABComeDatabase.instance.database;

    final id = await db!.insert(tablePolls, poll.toJson());
    return poll.copy(id: id);
  }

  // Método que atualiza uma votação
  static Future<Poll> update(Poll poll) async {
    final db = await ABComeDatabase.instance.database;

    await db!.update(
      tablePolls,
      poll.toJson(),
      where: '${PollFields.id} = ?',
      whereArgs: [poll.id],
    );

    return poll.copy(id: poll.id);
  }

  static Future<void> deleteById(int id) async {
    final db = await ABComeDatabase.instance.database;

    await db!.delete(
      tablePolls,
      where: '${PollFields.id} = ?',
      whereArgs: [id],
    );
  }
}