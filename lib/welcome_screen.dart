import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'shared_preferences_service.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Проверяем, авторизован ли пользователь
    if (SharedPreferencesService.isUserLoggedIn()) {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo[700]!, Colors.purple[600]!],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.menu_book, color: Colors.white, size: 50),
              ),
              const SizedBox(height: 30),
              const Text(
                'BookHub',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              const SizedBox(height: 10),
              const Text('Ваша цифровая библиотека', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 50),
              
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[600],
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Войти', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),
              
              OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.indigo[600],
                  side: BorderSide(color: Colors.indigo[600]!),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Зарегистрироваться', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}