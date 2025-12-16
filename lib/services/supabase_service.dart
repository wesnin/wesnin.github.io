import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  // Регистрация пользователя только в Auth
  static Future<Map<String, dynamic>> signUp(String email, String password, String name) async {
    try {
      final authResponse = await client.auth.signUp(
        email: email,
        password: password,
      );

      return {
        'success': true,
        'message': 'Проверьте почту и подтвердите email',
      };
    } on AuthException catch (e) {
      return {
        'success': false,
        'error': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Неизвестная ошибка: $e',
      };
    }
  }

  // Авторизация пользователя + создание профиля при первом входе
  static Future<AuthResponse> signIn(String email, String password) async {
    try {
      final signInResponse = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = signInResponse.user;
      if (user == null) {
        throw Exception('Пользователь не найден после входа');
      }

      // Проверяем, есть ли запись в Users
      final existingUser = await client
          .from('Users')
          .select()
          .eq('email', user.email!)
          .maybeSingle();

      if (existingUser == null) {
        // Создаём запись в Users
        await client.from('Users').insert({
          'username': 'Новый пользователь',
          'email': user.email!,
        });

        // Создаём профиль в UserProfiles
        await client.from('UserProfiles').insert({
          'user_id': user.id,
        });
      }

      return signInResponse;
    } on AuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Выход из системы
  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  // Получение текущего пользователя
  static User? get currentUser => client.auth.currentUser;

  // Получение данных пользователя из таблицы Users
  static Future<Map<String, dynamic>?> getUserData() async {
    try {
      final user = currentUser;
      if (user == null) return null;

      final response = await client
          .from('Users')
          .select()
          .eq('email', user.email!)
          .maybeSingle();

      return response;
    } catch (e) {
      return null;
    }
  }

  // Проверка авторизации
  static bool isLoggedIn() {
    return client.auth.currentUser != null;
  }
}