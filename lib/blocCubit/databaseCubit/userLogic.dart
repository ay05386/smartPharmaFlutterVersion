import 'package:bloc/bloc.dart';
import 'package:sqflite/sqflite.dart';

abstract class UserState {}

class InitUser extends UserState {}

class CreateUser extends UserState {}

class InsertUser extends UserState {}

class UpdateUser extends UserState {}

class DeleteUser extends UserState {}

class GetUser extends UserState {}

class UserLogic extends Cubit<UserState> {
  List<Map> users = [];
  late Database db;

  UserLogic() : super(InitUser());

  Future<void> createDatabaseAndTable() async {
    await openDatabase(
      'us.db',
      version: 2,
      onCreate: (Database d, int v) async {
        print('Database created!');
        await d.execute(
            'CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT, url TEXT)');
      },
      onOpen: (Database d) {
        print('Database Open!');
        db = d;
        emit(CreateUser());
        showData().then((value) {
          users = value;
          print(value);
          emit(GetUser());
        });
      },
    );
  }

  Future<void> insertUser({
    required String email,
    required String name,
    required String password,
    required String url,
  }) async {
    await db.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO user (name, email, password, url) VALUES (?, ?, ?, ?)',
        [name, email, password, url],
      ).then((value) {
        print('Inserted row $value');
        emit(InsertUser());
        showData().then((value) {
          users = value;
          print(value);
          emit(GetUser());
        });
      }).catchError((e) {
        print(e);
      });
    });
  }

  Future<void> updateUser({
    required String email,
    required String name,
    required String password,
    required String url,
    required int id,
  }) async {
    await db.rawUpdate(
      'UPDATE user SET name = ?, email = ?, password = ?, url = ? WHERE id = ?',
      [name, email, password, url, id],
    ).then((value) {
      print('User Updated');
      emit(UpdateUser());
      showData().then((value) {
        users = value;
        print(value);
        emit(GetUser());
      });
    });
  }

  Future<void> deleteUser(int id) async {
    await db.rawDelete(
      'DELETE FROM user WHERE id = ?',
      [id],
    ).then((value) {
      print('User Deleted $value');
      emit(DeleteUser());
      showData().then((value) {
        users = value;
        print(value);
        emit(GetUser());
      });
    });
  }

  Future<List<Map>> showData() async {
    return await db.rawQuery('SELECT * FROM user');
  }
}
