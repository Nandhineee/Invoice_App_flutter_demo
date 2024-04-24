import 'package:invoice/data/datasource/db_helper.dart';
import 'package:invoice/domain/models/user.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDataSource {
  Future<void> insertUserData(String password, String email) async {
    final Database db = DatabaseHelper.database!;

    await db.insert(
      'User',
      {'password': password, 'email': email},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> authUserDetails(String email, String password) async {
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result = await dbClient.rawQuery(
          '''select * from $userTableName WHERE $userEmail="$userEmail" AND $userPassword="$password";''');
      if (result.isNotEmpty) {
        return User.fromJson(result.first);
      } else {
        return null;
      }
    }
    return null;
  }
}
