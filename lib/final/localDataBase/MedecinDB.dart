import 'package:sqflite/sqflite.dart';

class MedicineDB {
  List<Map> medicine = [];
  Database? db;

  Future<void> CreateDatabaseAndTables() async {
    db = await openDatabase(
      'medicine.db',
      version: 1,
      onCreate: (db, version) async {
        print("database created!");
        await db.execute('''
          CREATE TABLE medicines(
            medicine_id INTEGER PRIMARY KEY,
            medicine_name TEXT,
            medicine_effective TEXT,
            medicine_quantity INTEGER,
            medicine_sold INTEGER,
            medicine_price INTEGER,
            name TEXT,
            email TEXT,
            password TEXT,
            url TEXT
          )
        ''');
        print("table created!");
      },
      onOpen: (db) {
        print("open database!");
      },
    );
    medicine = await showData();
  }

  Future<void> insertMedicine({
    required String name,
    required String effective,
    required int quantity,
    required int sold,
    required int price,
  }) async {
    await db?.transaction((txn) async {
      int id = await txn.rawInsert('''
        INSERT INTO medicines(
          medicine_name,
          medicine_effective,
          medicine_quantity,
          medicine_sold,
          medicine_price
        ) VALUES(?, ?, ?, ?, ?)
      ''', [name, effective, quantity, sold, price]);
      print("inserted raw $id");
    });
  }

  Future<List<Map>> showData() async {
    if (db == null) {
      return [];
    }
    return await db!.rawQuery('SELECT * FROM medicines');
  }
}