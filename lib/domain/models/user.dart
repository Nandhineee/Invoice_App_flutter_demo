const String userTableName = 'user';
const String userId = 'id';
const String userPassword = 'password';
const String userEmail = 'email';
const String userName = 'name';

class User {
  int id;
  String password;
  String email;
  String name;

  User(this.id, this.password, this.email, this.name);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      userId: id,
      userPassword: password,
      userEmail: email,
      userName: name,
    };
    return map;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json[userId],
      json[userPassword],
      json[userEmail],
      json[userName],
    );
  }
}

List<User> userDetails = [
  User(01, 'user', 'user@gmail.com', 'user'),
  User(02, 'divya', 'div@gmail.com', 'divya')
];
