import 'package:bloc/bloc.dart';
import 'package:chat/chat.dart';
import 'package:squadchat/cache/local_cache_contract.dart';
import 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  IUserService _userService;
  ILocalCache _localCache;

  HomeBloc(this._userService, this._localCache) : super(HomeInitial());

  Future<User> connect() async {
    final userJson = _localCache.fetch('USER');
    userJson['last_seen'] = DateTime.now();
    userJson['active'] = true;

    final user = User.fromJson(userJson);
    await _userService.connect(user);
    return user;
  }

  Future<void> activeUsers(User user) async {
    emit(HomeLoading());
    final users = await _userService.online();
    users.removeWhere((element) => element.id == user.id);
    emit(HomeSuccess(users));
  }
}
