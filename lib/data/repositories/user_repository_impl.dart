import 'package:invoice/data/datasource/local/user_data_source.dart';
import 'package:invoice/data/datasource/remote/login_api.dart';
import 'package:invoice/domain/models/user.dart';
import 'package:invoice/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;
  final UserApi userApi;

  UserRepositoryImpl(this.userDataSource, this.userApi);

  @override
  Future<User?> authUser(String email, String password) async {
    List<User>? users = await userApi.getUserFromApi();

    for (User user in users) {
      if (user.email == email && user.password == password) {
        return user;
      }
    }
    return null;
  }
}
