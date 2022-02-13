import 'package:abcome_app/database/abcome_database.dart';
import 'package:abcome_app/models/person.dart';

class PersonRepository {
  // <---------------------------------> Métodos CRUD à tabela de Pessoas <--------------------------------->

  // Método que devolve uma Pessoa pelo ID
  static Future<Person> readById(int id) async {
    final db = await ABComeDatabase.instance.database;

    final maps = await db!.query(
      tablePersons,
      columns: PersonFields.values,
      where: '${PersonFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Person.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found.');
    }
  }

  // Método que devolve uma Pessoa pelo Nome
  static Future<Person?> readByName(String name) async {
    final db = await ABComeDatabase.instance.database;

    final maps = await db!.query(
      tablePersons,
      columns: PersonFields.values,
      where: '${PersonFields.name} = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return Person.fromJson(maps.first);
    } else {
      return null;
    }
  }

  // Método que devolve todas as Pessoas
  static Future<List<Person>> readAll() async {
    final db = await ABComeDatabase.instance.database;

    final orderByName = '${PersonFields.name} ASC';

    // Ambas as propriedades result fazem a mesma coisa (a primeira permite usar sql puro)
    //final result = await db!.rawQuery('SELECT * FROM $tablePersons ORDER BY $orderByName');
    final result = await db!.query(tablePersons, orderBy: orderByName);

    return result.map((json) => Person.fromJson(json)).toList();
  }

  // Método que cria uma Pessoa
  static Future<Person> insert(Person person) async {
    final db = await ABComeDatabase.instance.database;

    final id = await db!.insert(tablePersons, person.toJson());
    return person.copy(id: id);
  }

  // Método que atualiza uma Pessoa
  static Future<int> update(Person person) async {
    final db = await ABComeDatabase.instance.database;

    return db!.update(
      tablePersons,
      person.toJson(),
      where: '${PersonFields.id} = ?',
      whereArgs: [person.id],
    );
  }

  // Método que apaga uma Pessoa
  static Future<int> delete(int personId) async {
    final db = await ABComeDatabase.instance.database;

    return db!.delete(
      tablePersons,
      where: '${PersonFields.id} = ?',
      whereArgs: [personId],
    );
  }
}