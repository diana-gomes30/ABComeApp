import 'package:abcome_app/database/abcome_database.dart';
import 'package:abcome_app/models/poll.dart';

class PollRepository {

  // Método que devolve a votação ativa por ano
  static Future<Poll?> readActiveByYear(int year) async {
    final db = await ABComeDatabase.instance.database;

    int active = 1;
    int cancelled = 0;

    final maps = await db!.query(
      tablePolls,
      columns: PollFields.values,
      where: '${PollFields.year} = ? AND ${PollFields.active} = ? AND ${PollFields.cancelled} = ?',
      whereArgs: [year, active, cancelled],
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
    int cancelled = 0;

    final maps = await db!.query(
      tablePolls,
      columns: PollFields.values,
      where: '${PollFields.year} = ? AND ${PollFields.active} = ? AND ${PollFields.cancelled} = ?',
      whereArgs: [currentYear, active, cancelled],
    );

    if (maps.isNotEmpty) {
      return Poll.fromJson(maps.first);
    } else {
      return null;
    }
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
}