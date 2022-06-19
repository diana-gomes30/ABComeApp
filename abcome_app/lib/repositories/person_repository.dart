import 'package:abcome_app/database/abcome_database.dart';
import 'package:abcome_app/models/person.dart';

class PersonRepository {
  // <---------------------------------> Métodos CRUD à tabela de Pessoas <--------------------------------->

  // Método que devolve uma Pessoa pelo ID
  static Future<Person?> readById(int id) async {
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
      return null;
    }
  }

  // Método que devolve uma Pessoa pelo Nome
  static Future<Person?> readByName(String name) async {
    final db = await ABComeDatabase.instance.database;

    int inactive = 0;

    final maps = await db!.query(
      tablePersons,
      columns: PersonFields.values,
      where: '${PersonFields.name} = ? and ${PersonFields.inactive} = ?',
      whereArgs: [name, inactive],
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
    List<Person> personList = [];

    const orderByName = '${PersonFields.name} ASC';
    int inactive = 0;

    final result = await db!.query(
      tablePersons,
      columns: PersonFields.values,
      where: '${PersonFields.inactive} = ?',
      whereArgs: [inactive],
      orderBy: orderByName,
    );
    personList = result.map((json) => Person.fromJson(json)).toList();

    return personList;
  }

  // Método que devolve todas as Pessoas que votarão
  static Future<List<Person>> readCanVote() async {
    final db = await ABComeDatabase.instance.database;
    List<Person> personList = [];

    const orderByName = '${PersonFields.name} ASC';
    int isVoting = 1;
    int inactive = 0;

    final result = await db!.query(
        tablePersons,
        columns: PersonFields.values,
        where: '${PersonFields.isVoting} = ? and ${PersonFields.inactive} = ?',
        whereArgs: [isVoting, inactive],
        orderBy: orderByName,
    );
    personList = result.map((json) => Person.fromJson(json)).toList();

    return personList;
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

  // Método o campo que permite votar para todas as Pessoas ativas
  static Future<int> updateVotingField() async {
    final db = await ABComeDatabase.instance.database;

    int isVoting = 0;
    int inactive = 0;

    return db!.rawUpdate(''
        'UPDATE $tablePersons '
        'SET ${PersonFields.isVoting} = $isVoting '
        'WHERE ${PersonFields.inactive} = $inactive'
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