import 'package:flutter/material.dart';
import 'package:bookly/services/supabase_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeTab(),
    BooksTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.menu_book, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              'Bookly',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await SupabaseService.signOut();
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, '/auth');
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Книги',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.menu_book, size: 80, color: Colors.blue),
            ),
            const SizedBox(height: 30),
            Text(
              'Добро пожаловать в Bookly!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              'Карманное пространство для удобного чтения электронныых книг',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.trending_up, color: Colors.green),
                        SizedBox(width: 10),
                        Text('Ваша статистика'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('5', 'Книг в библиотеке'),
                        _buildStatItem('1', 'Книга начата'),
                        _buildStatItem('3', 'Книги прочитаны'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BooksTab extends StatelessWidget {
  const BooksTab({super.key});

  Widget _buildBookItem(BuildContext context, String title, String author, String genre, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withAlpha(50),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.book, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(author),
            const SizedBox(height: 4),
            Chip(
              label: Text(genre),
              backgroundColor: color.withAlpha(25),
              labelStyle: TextStyle(color: color),
            ),
          ],
        ),
        trailing: const Icon(Icons.play_arrow, color: Colors.blue),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Функция чтения книги в разработке')),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Моя библиотека Bookly',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Здесь собраны все ваши книги',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildBookItem(context, 'Война и мир', 'Лев Толстой', 'Классика', Colors.blue),
                _buildBookItem(context, 'Преступление и наказание', 'Федор Достоевский', 'Классика', Colors.red),
                _buildBookItem(context, 'Мастер и Маргарита', 'Михаил Булгаков', 'Мистика', Colors.purple),
                _buildBookItem(context, '1984', 'Джордж Оруэлл', 'Антиутопия', Colors.orange),
                _buildBookItem(context, 'Гарри Поттер и философский камень', 'Дж. К. Роулинг', 'Фэнтези', Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }
}