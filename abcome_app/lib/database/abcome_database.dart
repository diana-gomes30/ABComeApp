import 'package:abcome_app/models/person.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ABComeDatabase {

  static final ABComeDatabase instance = ABComeDatabase._init();

  static Database? _database;

  ABComeDatabase._init();

  // <---------------------------------> Método que devolve a base de dados <--------------------------------->

  // Se existir o ficheiro da base de dados, então devolve-o, senão cria um e devolve o mesmo
  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDB('abcome.db');
      return _database;
    }
    return _database;
  }

  // <---------------------------------> Método que cria as tabelas da base de dados <--------------------------------->

  // Método que permite criar as tabelas
  Future<Database?> _createDB(Database db, int newVersion) async {
    // Type of properties
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    // Create Table Persons
    await db.execute('''
      CREATE TABLE $tablePersons (
      ${PersonFields.id} $idType,
      ${PersonFields.name} $textType,
      ${PersonFields.image} $textType
      )''');
  }


  // <-----------------------------------> Para apagar a base de dados <----------------------------------->
  Future<void> deleteDatabase() => databaseFactory.deleteDatabase('abcome.db');

    // <---------------------------------> Métodos de ligação à base de dados <--------------------------------->

  // Método que permite fazer a ligação à base de dados
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Método que permite fechar a ligação à base de dados
  Future close() async {
    final db = await instance.database;

    return db!.close();
  }


  // <---------------------------------> Métodos CRUD à tabela de Pessoas <--------------------------------->

  // Método que devolve uma Pessoa pelo ID
  Future<Person> readPerson(int id) async {
    final db = await instance.database;

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
  Future<Person?> readPersonByName(String name) async {
    final db = await instance.database;

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
  Future<List<Person>> readAllPersons() async {
    final db = await instance.database;

    final orderByName = '${PersonFields.name} ASC';

    // Ambas as propriedades result fazem a mesma coisa (a primeira permite usar sql puro)
    //final result = await db!.rawQuery('SELECT * FROM $tablePersons ORDER BY $orderByName');
    final result = await db!.query(tablePersons, orderBy: orderByName);

    return result.map((json) => Person.fromJson(json)).toList();
  }

  // Método que cria uma Pessoa
  Future<Person> insertPerson(Person person) async {
    final db = await instance.database;

    final id = await db!.insert(tablePersons, person.toJson());
    return person.copy(id: id);
  }

  // Método que atualiza uma Pessoa
  Future<int> updatePerson(Person person) async {
    final db = await instance.database;

    return db!.update(
      tablePersons,
      person.toJson(),
      where: '${PersonFields.id} = ?',
      whereArgs: [person.id],
    );
  }

  // Método que apaga uma Pessoa
  Future<int> deletePerson(int personId) async {
    final db = await instance.database;

    return db!.delete(
      tablePersons,
      where: '${PersonFields.id} = ?',
      whereArgs: [personId],
    );
  }

}