import 'package:abcome_app/database/abcome_database.dart';
import 'package:abcome_app/models/statistic.dart';

class StatisticRepository {

  // Método que devolve a estatística por pessoa e votação
  static Future<Statistic?> readByPersonPoll(int idPerson, int idPoll) async {
    final db = await ABComeDatabase.instance.database;

    final maps = await db!.query(
      tableStatistics,
      columns: StatisticFields.values,
      where: '${StatisticFields.personId} = ? AND ${StatisticFields.pollId} = ?',
      whereArgs: [idPerson, idPoll],
    );

    if (maps.isNotEmpty) {
      return Statistic.fromJson(maps.first);
    } else {
      return null;
    }
  }

  // Método que devolve a estatística por pessoa e votação para presidente
  static Future<List<Statistic>> readPresidentByPoll(int idPoll) async {
    final db = await ABComeDatabase.instance.database;

    const orderByVotes = '${StatisticFields.presidentNumVotes} DESC';
    int numVotes = 0;

    final result = await db!.query(
      tableStatistics,
      columns: StatisticFields.values,
      where: '${StatisticFields.pollId} = ? AND ${StatisticFields.presidentNumVotes} > ?',
      whereArgs: [idPoll, numVotes],
      orderBy: orderByVotes,
    );

    return result.map((json) => Statistic.fromJson(json)).toList();
  }

  // Método que devolve a estatística por pessoa e votação para tesoureiro
  static Future<List<Statistic>> readTreasurerByPoll(int idPoll) async {
    final db = await ABComeDatabase.instance.database;

    const orderByVotes = '${StatisticFields.treasurerNumVotes} DESC';
    int numVotes = 0;

    final result = await db!.query(
      tableStatistics,
      columns: StatisticFields.values,
      where: '${StatisticFields.pollId} = ? AND ${StatisticFields.treasurerNumVotes} > ?',
      whereArgs: [idPoll, numVotes],
      orderBy: orderByVotes,
    );

    return result.map((json) => Statistic.fromJson(json)).toList();
  }

  // Método que devolve todas as estatísticas
  static Future<List<Statistic>> readAll() async {
    final db = await ABComeDatabase.instance.database;

    final result = await db!.query(
      tableStatistics,
      orderBy: '${StatisticFields.id} ASC',
    );

    return result.map((json) => Statistic.fromJson(json)).toList();
  }

  // Método que devolve todas as estatísticas por votação
  static Future<List<Statistic>> readAllByPoll(int idPoll) async {
    final db = await ABComeDatabase.instance.database;

    final result = await db!.query(
      tableStatistics,
      where: '${StatisticFields.pollId} = ?',
      whereArgs: [idPoll],
      orderBy: '${StatisticFields.pollId}, ${StatisticFields.personId} ASC',
    );

    return result.map((json) => Statistic.fromJson(json)).toList();
  }

  // Método que cria um registo de estatistica
  static Future<Statistic> insert(Statistic statistic) async {
    final db = await ABComeDatabase.instance.database;

    final id = await db!.insert(tableStatistics, statistic.toJson());
    return statistic.copy(id: id);
  }

  // Método que atualiza um registo de estatística existente
  static Future<Statistic> update(Statistic statistic) async {
    final db = await ABComeDatabase.instance.database;

    await db!.update(
      tableStatistics,
      statistic.toJson(),
      where: '${StatisticFields.id} = ?',
      whereArgs: [statistic.id],
    );

    return statistic.copy(id: statistic.id);
  }

  static Future<void> deleteByPoll(int idPoll) async {
    final db = await ABComeDatabase.instance.database;

    await db!.delete(
      tableStatistics,
      where: '${StatisticFields.pollId} = ?',
      whereArgs: [idPoll],
    );
  }
}