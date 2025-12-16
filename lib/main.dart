import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/auth_screen.dart';
import 'screens/main_screen.dart';
import 'screens/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  print('Инициализация Bookly...');
  
  try {
    await Supabase.initialize(
      url: 'https://lgxlsgvespydfnovczzi.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxneGxzZ3Zlc3B5ZGZub3ZjenppIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU2MTAyMjMsImV4cCI6MjA4MTE4NjIyM30.3l69-IKMkvbCJ1N3HyL7eYgAwaRN1JxslxmRMqqKiPo',
    );
    
    print('Supabase успешно инициализирован!');
    
    runApp(const BooklyApp());
  } catch (e) {
    print('Ошибка инициализации Supabase: $e');
    runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Bookly - Оффлайн режим')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Приложение запущено в оффлайн режиме'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  runApp(const BooklyApp());
                },
                child: const Text('Попробовать снова'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookly - E-Book Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Добавляем тему для BottomNavigationBar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,   
          unselectedItemColor: Colors.grey,     
          backgroundColor: Colors.white,       
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => const AuthScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}