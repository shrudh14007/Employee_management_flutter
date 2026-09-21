import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crud_flutter_todo/user.dart';

class DatabaseService {
  static Database? _db;

  static final DatabaseService instance =
      DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await getDatabase();

    return _db!;
  }

  Future<List<User>> getUsers() async {
  final db = await database;

  final data = await db.query('users');

  return data.map((e) {
    return User(
      e['id'] as int,
      e['name'] as String,
      e['profession'] as String,
    );
  }).toList();
}

Future<void> addUser(
  String name,
  String profession,
) async {
  final db = await database;

  await db.insert(
    'users',
    {
      'name': name,
      'profession': profession,
    },
  );
}

Future<void> updateUser(int id, String name, String profession)async{
  final db = await database;
  await db.update(
    'users',
    {
      'name':name,
      'profession':profession
    },
    where: 'id=?',
    whereArgs:[id],
  );
}

Future <void> deleteUser(int id)async{
 final db = await database;
 await db.delete(
  'users',
  where:'id=?',
  whereArgs:[id],
 );
}



  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(
      databaseDirPath,
      'master_db.db',
    );

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            profession TEXT NOT NULL
          )
        ''');
      },
    );

    return database;
  }
}