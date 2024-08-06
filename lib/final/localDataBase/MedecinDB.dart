import 'package:sqflite/sqflite.dart';

class MedicineDB {
  List<Map> medicine = [];
  late Database db;
  CreateDatabaseAndTables ()async{
    db=await openDatabase(
      'medicine.db',
      version: 1,
      onCreate: (db, version) async{
        print("data base created !");
        await db.execute('create table medicines( '
            ' medicine_id INTEGER PRIMARY KEY,'
            'medicine_name TEXT,'
            'medicine_effective TEXT,'
            'medicine_quantity INTEGER,'
            ' medicine_sold INTEGER,'
            'medicine_price INTEGER,'
            'name text,email text,password text,url text)');
        print("table created !");
      },
      onOpen: (db) {
        print("open database !");
      },
    );
    showData().then((value) {
      medicine=value;
    });
  }
  insertMedicine({
    required String name,
    required String effective,
    required int quantity,
    required int sold,
    required int price,
  })
  {
    db.transaction((txn) async{
      txn.rawInsert('insert into medicines(medicine_name,medicine_effective,medicine_quantity,medicine_sold,medicine_price)'
          'values("$name","$effective",$quantity,$sold,$price)').then((value){
        print("inserted raw $value");
      }).catchError((e){
        print(e);
      });
    });

  }
  Future <List<Map>> showData(){
    return db.rawQuery('select * from medicines');
  }
}