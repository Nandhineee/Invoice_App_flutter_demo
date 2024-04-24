import 'package:dio/dio.dart';
import 'package:invoice/domain/models/user.dart';

class UserApi {
  Future<List<User>> getUserFromApi() async {
    List<User> users = [];
    final dio = Dio();
    var response = await dio.get("https://retoolapi.dev/z4aXuY/usertable");
    for (var res in response.data) {
      if (res["name"] != null) {
        users.add(User.fromJson(res));
      }
    }
    return users;
  }
}
