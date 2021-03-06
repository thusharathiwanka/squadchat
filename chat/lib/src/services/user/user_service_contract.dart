import 'package:chat/src/models/user.dart';

abstract class IUserService {
  Future<User> connect(User user);
  Future<List<User>> online();
  Future<void> disconnect(String userId);
  Future<void> reconnect(String userId);
  Future<void> deleteUser(String userId);
  Future<User> fetchUser(String userId);
  Future<List<User>> fetch(List<String> chatId);
}
