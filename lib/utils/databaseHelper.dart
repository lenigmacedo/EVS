import 'package:evs_prot/models/ResponsiblesModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String table = 'responsible_table';
  String colId = 'id';
  String colCodigo = 'codigo';
  String colNome = 'nome';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var path = 'EVS.db';

    var evsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return evsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $table($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colCodigo INTEGER, '
        ' $colNome TEXT)');
  }

  Future<List<Map<String, dynamic>>> getResponsibleMapList() async {
    Database db = await this.database;

    var result = await db.query(table);
    return result;
  }

  Future<int> insertResponsible(Responsibles responsibles) async {
    Database db = await this.database;
    var result = await db.insert(table, responsibles.toMap());
    return result;
  }

  Future<List<Responsibles>> getResponsiblesList() async {
    var responsibleMapList = await getResponsibleMapList();
    int count = responsibleMapList.length;

    List<Responsibles> responsibleList = List<Responsibles>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      responsibleList.add(Responsibles.fromMapObject(responsibleMapList[i]));
    }

    return responsibleList;
  }
}
