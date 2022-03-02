import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/person_type.dart';
import 'package:abcome_app/models/setting.dart';
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

    // Create Table Person Types
    await db.execute('''
      CREATE TABLE $tablePersonTypes (
      ${PersonTypeFields.id} $idType,
      ${PersonTypeFields.type} $textType,
      ${PersonTypeFields.description} $textType
      )''');

    // Create Table Settings
    await db.execute('''
      CREATE TABLE $tableSettings (
      ${SettingFields.id} $idType,
      ${SettingFields.year} $idType,
      ${SettingFields.personLimit} $idType,
      ${SettingFields.fkSettingPerson} $textType,
      ${SettingFields.fkSettingPersonType} $textType,
      FOREIGN KEY (${SettingFields.fkSettingPerson}) REFERENCES $tablePersons (${PersonFields.id}),
      FOREIGN KEY (${SettingFields.fkSettingPersonType}) REFERENCES $tablePersonTypes (${PersonTypeFields.id})
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
}
