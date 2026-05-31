import 'package:dar_plus/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  static const String _userKey = 'currentUser';

  Future<User?> login(String email, String password) async {
    // Simulamos una autenticación exitosa si el email y la contraseña son válidos
    // En un entorno real, aquí se haría una llamada a una API o a Firebase
    if (email == 'test@example.com' && password == 'password123') {
      final user = User(id: '1', name: 'Usuario de Prueba', email: email);
      await _saveUserLocally(user);
      return user;
    } else if (email == 'admin@example.com' && password == 'admin123') {
      final user = User(id: '2', name: 'Administrador', email: email);
      await _saveUserLocally(user);
      return user;
    }
    return null; // Autenticación fallida
  }

  Future<User?> register(String name, String email, String password) async {
    // Simulamos un registro exitoso
    // En un entorno real, aquí se crearía un nuevo usuario en la base de datos
    final user = User(id: DateTime.now().millisecondsSinceEpoch.toString(), name: name, email: email);
    await _saveUserLocally(user);
    return user;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  Future<void> recoverPassword(String email) async {
    // Simulamos el envío de un correo de recuperación
    // En un entorno real, aquí se haría una llamada a una API para enviar el correo
    print('Se ha enviado un correo de recuperación a $email');
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    if (userData != null) {
      return User.fromJson(json.decode(userData));
    }
    return null;
  }

  Future<void> _saveUserLocally(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, json.encode(user.toJson()));
  }
}
