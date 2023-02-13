import 'package:papa_burger/src/restaurant.dart';
import 'package:papa_burger/src/services/repositories/user/base_user_repository.dart';

class UserRepository implements BaseUserRepository{
  UserRepository({
    required this.api,
  });

  final Api api;

  @override
  Future<void> logIn(String email, String password) async {
    try {
      final storage = Prefs.instance;
      final apiUser = await api.signIn(email, password);
      logger.i(apiUser);
      await storage.saveToken(apiUser.token);
      await storage.saveEmail(email);
    } on InvalidCredentialsApiException {
      logger.e('Invalid Credentials');
      throw InvalidCredentialsException();
    }
  }

  @override
  Future<void> googleLogIn() async {
    try {
      final storage = Prefs.instance;
      final googleUser = await api.googleSignIn();

      await storage.saveEmail(googleUser.email!);
      await storage.saveUsername(googleUser.username!);
      await storage.saveToken(googleUser.token);
    } on InvalidCredentialsApiException {
      throw InvalidCredentialsException();
    }
  }

  @override
  Future<void> logOut() async {
    await api.signOut();
  }
}
