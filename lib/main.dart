import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://hogfvggthtmezcdatnhn.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhvZ2Z2Z2d0aHRtZXpjZGF0bmhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAxMTczMDIsImV4cCI6MjA3NTY5MzMwMn0.MrEc_6Yp0rdOXiwFLyQjfN-eTulhQlwSxathZBw0Ato';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Блок 1: Красный контейнер ===
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Круглая аватарка
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: Center(child: Text('PHOTO', style: TextStyle(fontSize: 10))),
                      ),
                      // Кнопка / текст справа
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.green[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('BUTTON "ТЕКСТ"', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Два текстовых поля
                  Container(
                    height: 40,
                    width: double.infinity,
                    color: Colors.green[200],
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Center(child: Text('ТЕКСТ')),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    color: Colors.green[200],
                    child: Center(child: Text('ТЕКСТ')),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // === Блок 2: Зелёный + Розовый ===
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 80,
                          color: Colors.green[200],
                          margin: const EdgeInsets.only(right: 8),
                          child: Center(child: Text('ТЕКСТ')),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 80,
                          color: Colors.green[200],
                          child: Center(child: Text('ТЕКСТ')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 100,
                    color: Colors.pink[100],
                    child: Center(child: Text('SCROL')),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // === Блок 3: Аналогично блоку 2 ===
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          color: Colors.green[200],
                          margin: const EdgeInsets.only(right: 8),
                          child: Center(child: Text('ТЕКСТ')),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          color: Colors.green[200],
                          child: Center(child: Text('ТЕКСТ')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 100,
                    color: Colors.pink[100],
                    child: Center(child: Text('SCROL')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}