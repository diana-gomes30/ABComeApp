import 'package:abcome_app/database/abcome_database.dart';
import 'package:abcome_app/models/statistic.dart';

class StatisticRepository {

  // Método que cria um registo de estatistica
  static Future<Statistic> insert(Statistic statistic) async {
    final db = await ABComeDatabase.instance.database;

    final id = await db!.insert(tableStatistics, statistic.toJson());
    return statistic.copy(id: id);
  }

}