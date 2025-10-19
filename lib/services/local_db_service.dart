import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDbService {
  static Database? _db;

  // Ouvre la base ou la crée si elle n'existe pas
  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pokedexdb');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        for (final tableSql in getCreateTableStrings()) {
          await db.execute(tableSql);
        }
      },
    );
  }

  // Exemple d'insertion
  static Future<int> insertExample(String name) async {
    final db = await database;
    return await db.insert('example', {'name': name});
  }

  // Exemple de lecture
  static Future<List<Map<String, dynamic>>> getAllExamples() async {
    final db = await database;
    return await db.query('example');
  }

  // Toutes les chaînes de création de tables
  static List<String> getCreateTableStrings() {
    return [
      '''
      CREATE TABLE Pokemons(
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        PokedexId INTEGER NOT NULL,
        Name TEXT NOT NULL,
        Generation INTEGER NOT NULL,
        ImagePath TEXT NOT NULL,
        NextPokemonId INTEGER,
        PreviousPokemonId INTEGER
      )
      '''
      // Ajoute ici d'autres chaînes de création de tables si besoin
    ];
  }
}
