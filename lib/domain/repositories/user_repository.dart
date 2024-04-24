import 'package:invoice/domain/models/user.dart';

abstract class UserRepository {
  Future<User?> authUser(String email, String password);
}
