import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;
  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'student.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        class TEXT,
        rollno INTEGER,
        division TEXT,
        password TEXT,
        character_code TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE students ADD COLUMN character_code TEXT');
    }
  }

  Future<void> insertStudent(String name, String email, String className, int rollNo, String division, String password) async {
    final db = await database;
    final hashedPassword = await hashPassword(password);
    await db.insert(
      'students',
      {
        'name': name,
        'email': email,
        'class': className,
        'rollno': rollNo,
        'division': division,
        'password': hashedPassword,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getStudents() async {
    final db = await database;
    return await db.query('students');
  }

  Future<String> hashPassword(String password) async {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(password, iv: iv);
    return '${encrypted.base64}:${key.base64}:${iv.base64}';
  }

  Future<bool> checkUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'students',
      where: 'email = ? AND password=?',
      whereArgs: [email, password],
    );

    // if (result.isNotEmpty) {
    //   final storedHash = result.first['password'] as String;
    //   final parts = storedHash.split(':');
    //   if (parts.length != 3) return false;
    //
    //   final encryptedPassword = parts[0];
    //   final key = encrypt.Key.fromBase64(parts[1]);
    //   final iv = encrypt.IV.fromBase64(parts[2]);
    //   final encrypter = encrypt.Encrypter(encrypt.AES(key));
    //
    //   final decryptedPassword = encrypter.decrypt64(encryptedPassword, iv: iv);
    //   return decryptedPassword == password;
    // }
    return result.isNotEmpty;
  }

  Future<void> forgetPassword(String email, String characterCode) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'students',
      where: 'email = ? AND character_code = ?',
      whereArgs: [email, characterCode],
    );

    if (result.isNotEmpty) {
      // Handle password reset
    } else {
      // Handle invalid character code
    }
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}