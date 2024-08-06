import 'package:sqflite/sqflite.dart';

class UserDB {
  List<Map> medicine = [];
  List<Map> users = [];
  late Database db;

  Future<void> CreateDatabaseAndTables() async {
    print("Starting database creation");
    db = await openDatabase(
      'user.db',
      version: 2,
      onCreate: (db, version) async {
        print("Database created!");
        await createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        print("Upgrading database");
        await db.execute('DROP TABLE IF EXISTS user');
        await db.execute('DROP TABLE IF EXISTS medicines');
        await createTables(db);
      },
      onOpen: (db) {
        print("Database opened!");
      },
    );
    print("Database initialization complete");

    bool userTableExists = await isTableExists('user');
    bool medicinesTableExists = await isTableExists('medicines');
    print("User table exists: $userTableExists");
    print("Medicines table exists: $medicinesTableExists");

    showData().then((value) {
      users = value;
    });
    showMedicine().then((value) {
      medicine = value;
    });
  }

  Future<void> createTables(Database db) async {
    await db.execute(
        'CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)');
    print("User table created!");

    await db.execute(
        'CREATE TABLE medicines (id INTEGER PRIMARY KEY, name TEXT, price INTEGER, quantity INTEGER)');
    print("Medicines table created!");
  }

  Future<bool> isTableExists(String tableName) async {
    List<Map> result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    return result.isNotEmpty;
  }

  Future<void> insertUser(
      {required String name,
        required String email,
        required String password}) async {
    print("Inserting user");
    await db.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO user(name,email,password) VALUES("$name","$email","$password")');
    });
  }

  Future<void> insertMedicine(
      {required String name, required int price, required int quantity}) async {
    print("Inserting medicine");
    await db.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO medicines(name,price,quantity) VALUES("$name","$price","$quantity")');
    });
  }

  Future<List<Map>> showData() async {
    return await db.rawQuery('SELECT * FROM user');
  }

  Future<List<Map>> showMedicine() async {
    return await db.rawQuery('SELECT * FROM medicines');
  }

  Future<void> deleteUser({required int id}) async {
    await db.rawDelete('DELETE FROM user WHERE id=$id');
  }
}
