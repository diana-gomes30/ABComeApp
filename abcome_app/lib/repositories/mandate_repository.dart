import 'package:abcome_app/database/abcome_database.dart';
import 'package:abcome_app/models/mandate.dart';

class MandateRepository {
  // <---------------------------------> Métodos CRUD à tabela de Mandatos <--------------------------------->

  // Método que devolve um Mandato por defeito
  static Future<Mandate> readDefault() async {
    final db = await ABComeDatabase.instance.database;
    const id = 0;

    final maps = await db!.query(
      tableMandates,
      columns: MandateFields.values,
      where: '${MandateFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Mandate.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found.');
    }
  }

  // Método que devolve um Mandato pelo ID
  static Future<Mandate> readById(int id) async {
    final db = await ABComeDatabase.instance.database;

    final maps = await db!.query(
      tableMandates,
      columns: MandateFields.values,
      where: '${MandateFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Mandate.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found.');
    }
  }

  // Método que devolve um Mandato pelo Ano
  static Future<Mandate?> readByYear(int year) async {
    final db = await ABComeDatabase.instance.database;

    final maps = await db!.query(
      tableMandates,
      columns: MandateFields.values,
      //where: '${MandateFields.yearIni} = ?',
      //whereArgs: [year],
    );

    if (maps.isNotEmpty) {
      return Mandate.fromJson(maps.first);
    } else {
      return null;
    }
  }

  // Método que devolve o último Mandato
  static Future<Mandate?> readLast() async {
    final db = await ABComeDatabase.instance.database;

    final maps = await db!.query(
      tableMandates,
      columns: MandateFields.values,
      //orderBy: '${MandateFields.yearIni} DESC'
    );

    if (maps.isNotEmpty) {
      return Mandate.fromJson(maps.first);
    } else {
      return null;
    }
  }

  // Método que devolve todos os mandatos
  static Future<List<Mandate>> readAll() async {
    final db = await ABComeDatabase.instance.database;

    //const orderByYear = '${MandateFields.yearIni} DESC';

    // Ambas as propriedades result fazem a mesma coisa (a primeira permite usar sql puro)
    //final result = await db!.rawQuery('SELECT * FROM tableMandates ORDER BY $orderByYear');
    final result = await db!.query(tableMandates);

    return result.map((json) => Mandate.fromJson(json)).toList();
  }

  // Método que cria um mandato
  static Future<Mandate> insert(Mandate mandate) async {
    final db = await ABComeDatabase.instance.database;

    //print('Mandate: ${mandate.president} / ${mandate.treasurer} / ${mandate.yearIni} / ${mandate.yearFim}');
    final id = await db!.insert(tableMandates, mandate.toJson());
    return mandate.copy(id: id);
  }

  // Método que atualiza um mandato
  static Future<int> update(Mandate mandate) async {
    final db = await ABComeDatabase.instance.database;

    return db!.update(
      tableMandates,
      mandate.toJson(),
      where: '${MandateFields.id} = ?',
      whereArgs: [mandate.id],
    );
  }

  // Método que apaga um mandato
  static Future<int> delete(int mandateId) async {
    final db = await ABComeDatabase.instance.database;

    return db!.delete(
      tableMandates,
      where: '${MandateFields.id} = ?',
      whereArgs: [mandateId],
    );
  }
}
