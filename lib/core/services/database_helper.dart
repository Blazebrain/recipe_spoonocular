import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/recipes/data/models/recipes.dart';

class DatabaseHelper {
  static const _databaseName = "recipe_database.db";
  static const _databaseVersion = 1;

  static const table = 'recipes';

  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnImageUrl = 'image';

  // Singleton instance
  static DatabaseHelper? _instance;
  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._();
    return _instance!;
  }

  // Database reference
  static Database? _database;
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  DatabaseHelper._();

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnImageUrl TEXT
      )
      ''');
  }

  Future<void> insertRecipes(List<Recipe> recipes) async {
    final db = await database;
    final batch = db.batch();
    for (final recipe in recipes) {
      batch.insert(table, recipe.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<List<Recipe>> getRecipes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return maps.map((map) => Recipe.fromJson(map)).toList();
  }
}
