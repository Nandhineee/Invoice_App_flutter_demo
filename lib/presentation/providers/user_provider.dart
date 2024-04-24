import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/data/datasource/local/user_data_source.dart';
import 'package:invoice/data/datasource/remote/login_api.dart';
import 'package:invoice/data/repositories/user_repository_impl.dart';
import 'package:invoice/domain/models/user.dart';
import 'package:invoice/domain/repositories/user_repository.dart';

final userDetailsDataSourceProvider = Provider((ref) => UserDataSource());

final userDetailsApiProvider= Provider((ref) => UserApi());

final userDetailsRepositoryProvider = Provider<UserRepository>((ref)
{
  final userDetailsDataSource=ref.read(userDetailsDataSourceProvider);
  final userDetailsApi=ref.read(userDetailsApiProvider);

  return UserRepositoryImpl(userDetailsDataSource,userDetailsApi);
});

final authUserDetailsProvider = StateNotifierProvider((ref) {


  UserRepository userRepository = ref.read(userDetailsRepositoryProvider);

  return AuthUserDetailsNotifier(userRepository);
});


//// class AuthUserDetailsNotifier extends StateNotifier<dynamic> {
// //   final UserRepository userRepository;
// //
// //   AuthUserDetailsNotifier(this.userRepository) : super(dynamic);
// //
// //   Future<void> authUserDetails(String userEmail, String password) async {
// //     final userDataOrNotFound =
// //     await userRepository.authUser(userEmail, password);
// //     userDataOrNotFound.fold((l) => state = l, (r) => state = r.message);
// //   }


class AuthUserDetailsNotifier extends StateNotifier<dynamic>{

  final UserRepository userRepository;

  AuthUserDetailsNotifier( this.userRepository):super (dynamic);


  Future<User?> authUserDetails(String Email, String password) async {
    state=await userRepository.authUser(Email, password);
    return null;
  }

  dynamic getAuthUserDetails() {
    return state;
  }


}


