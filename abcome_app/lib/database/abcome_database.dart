import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/models/statistic.dart';
import 'package:abcome_app/models/mandate.dart';
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

  // <---------------------------------> Método que cria as tabelas da base de dados <--------------------------------->

  // Método que permite criar as tabelas
  Future<Database?> _createDB(Database db, int newVersion) async {
    // Type of properties
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const intType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    // Create Table Persons
    await db.execute('''
      CREATE TABLE $tablePersons (
      ${PersonFields.id} $idType,
      ${PersonFields.name} $textType,
      ${PersonFields.image} $textType,
      ${PersonFields.wasPresident} $boolType,
      ${PersonFields.wasTreasurer} $boolType,
      ${PersonFields.isVoting} $boolType,
      ${PersonFields.inactive} $boolType
      )''');

    // Create Table Polls
    await db.execute('''
    CREATE TABLE $tablePolls (
    ${PollFields.id} $idType,
    ${PollFields.numPersons} $intType,
    ${PollFields.year} $intType,
    ${PollFields.presidentId} $intType,
    ${PollFields.treasurerId} $intType,
    ${PollFields.active} $boolType
    )''');

    // Create Table Statistics
    await db.execute('''
    CREATE TABLE $tableStatistics (
    ${StatisticFields.id} $idType,
    ${StatisticFields.personId} $intType,
    ${StatisticFields.pollId} $intType,
    ${StatisticFields.presidentNumVotes} $intType,
    ${StatisticFields.treasurerNumVotes} $intType,
    CONSTRAINT fk_poll FOREIGN KEY (${StatisticFields.pollId}) REFERENCES $tablePolls(${PollFields.id}),
    CONSTRAINT fk_person FOREIGN KEY (${StatisticFields.personId}) REFERENCES $tablePersons(${PersonFields.id})
    )''');

    // Create Table Mandates
    await db.execute('''
      CREATE TABLE $tableMandates (
      ${MandateFields.id} $idType,
      ${MandateFields.personLimit} $intType,
      ${MandateFields.presidentId} $intType,
      ${MandateFields.treasurerId} $intType,
      ${MandateFields.active} $boolType,
      ${MandateFields.pollId} $intType,
      CONSTRAINT fk_president FOREIGN KEY (${MandateFields.presidentId}) REFERENCES $tablePersons(${PersonFields.id}),
      CONSTRAINT fk_treasurer FOREIGN KEY (${MandateFields.treasurerId}) REFERENCES $tablePersons(${PersonFields.id}),
      CONSTRAINT fk_poll FOREIGN KEY (${MandateFields.pollId}) REFERENCES $tablePolls(${PollFields.id})
      )''');

      await insertDefaultData(db);
  }

  Future<void> insertDefaultData(Database db) async {
    final defaultPresident = Person(
      id: 1,
      name: 'Presidente',
      image: '',
      wasPresident: 1,
      wasTreasurer: 0,
      isVoting: 0,
      inactive: 0, // False
    );
    await db.insert(tablePersons, defaultPresident.toJson());

    final defaultTreasurer = Person(
      id: 2,
      name: 'Tesoureiro',
      image: '',
      wasPresident: 0,
      wasTreasurer: 1,
      isVoting: 0,
      inactive: 0, // False
    );
    await db.insert(tablePersons, defaultTreasurer.toJson());

    int year = (DateTime.now().year)-1;
    final defaultPoll = Poll(
      id: 1,
      numPersons: 0,
      year: year,
      presidentId: defaultPresident.id ?? 1,
      treasurerId: defaultTreasurer.id ?? 2,
      active: 0, // False
    );
    await db.insert(tablePolls, defaultPoll.toJson());

    final defaultMandate = Mandate(
      id: 1,
      personLimit: 20,
      presidentId: defaultPresident.id ?? 1,
      treasurerId: defaultTreasurer.id ?? 2,
      pollId: 1,
      active: 1, // True
    );
    await db.insert(tableMandates, defaultMandate.toJson());
  }

  // <-----------------------------------> Para apagar a base de dados <----------------------------------->
  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'abcome.db');
    databaseFactory.deleteDatabase(path);
  }
}
