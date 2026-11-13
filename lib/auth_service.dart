class AuthService {
  static final Map<String, String> _users = {};
  static String currentUser = 'Student';

  static bool register(String username, String password) {
    final key = username.trim().toLowerCase();
    if (_users.containsKey(key)) return false;
    _users[key] = password;
    return true;
  }

  static bool login(String username, String password) {
    final key = username.trim().toLowerCase();
    if (_users[key] == password) {
      currentUser = username.trim();
      return true;
    }
    return false;
  }

  static void logout() {
    currentUser = 'Student';
  }
}