abstract class BaseUserRepository {
  Future<void> logIn(String email, String password);
  Future<void> googleLogIn();
  Future<void> logOut();
}
