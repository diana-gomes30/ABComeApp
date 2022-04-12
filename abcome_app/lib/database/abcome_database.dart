import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/person_type.dart';
import 'package:abcome_app/models/mandate.dart';
import 'package:abcome_app/repositories/mandate_repository.dart';
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
    const intType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    // Create Table Persons
    await db.execute('''
      CREATE TABLE $tablePersons (
      ${PersonFields.id} $idType,
      ${PersonFields.name} $textType,
      ${PersonFields.image} $textType
      )''');

    // Create Table Mandates
    await db.execute('''
      CREATE TABLE $tableMandates (
      ${MandateFields.id} $idType,
      ${MandateFields.president} $intType,
      ${MandateFields.treasurer} $intType,
      ${MandateFields.yearIni} $intType,
      ${MandateFields.yearFim} $intType,
      ${MandateFields.personLimit} $intType
      )''');

    final defaultMandate = Mandate(
      id: 0,
      president: 0,
      treasurer: 0,
      yearIni: 2021,
      yearFim: 2022,
      personLimit: 5,
    );
    await db.insert(tableMandates, defaultMandate.toJson());
  }

  // <-----------------------------------> Para apagar a base de dados <----------------------------------->
  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'abcome.db');
    databaseFactory.deleteDatabase(path);
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
}
