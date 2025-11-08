import 'package:flutter/material.dart';
import 'supabase_service.dart';
import 'shared_preferences_service.dart';
import 'book_model.dart';
import 'future_builder_widget.dart';

class LibraryHomePage extends StatefulWidget {
  const LibraryHomePage({super.key});

  @override
  _LibraryHomePageState createState() => _LibraryHomePageState();
}

class _LibraryHomePageState extends State<LibraryHomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeTab(),
    const CatalogTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _addBook,
        backgroundColor: Colors.indigo[600],
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Каталог'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }

  void _addBook() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить книгу'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(decoration: const InputDecoration(labelText: 'Название')),
            TextFormField(decoration: const InputDecoration(labelText: 'Автор')),
            TextFormField(decoration: const InputDecoration(labelText: 'Описание')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          ElevatedButton(onPressed: () {}, child: const Text('Добавить')),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.indigo[700]!, Colors.purple[600]!]),
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BookHub', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('Ваша цифровая библиотека', style: TextStyle(fontSize: 14, color: Colors.white70)),
                    ],
                  ),
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.notifications, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.teal[100]!),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Добро пожаловать! 👋', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
                SizedBox(height: 8),
                Text('У вас 3 книги на чтении. Не забудьте вернуть до 15 декабря', style: TextStyle(color: Colors.teal)),
              ],
            ),
          ),
          
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              _buildStatItem('12', 'Книг\nпрочитано'),
              _buildStatItem('3', 'На\nчтении'),
              _buildStatItem('8', 'В\nсписке'),
            ]),
          ),
          
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Книги на чтении', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          SizedBox(height: 200, child: BooksFutureBuilder(status: 'reading')),
        ],
      ),
    );
  }

  Widget _buildStatItem(String count, String text) {
    return Column(children: [
      Text(count, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo)),
      Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
    ]);
  }
}

class CatalogTab extends StatelessWidget {
  const CatalogTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: const TabBar(
              tabs: [
                Tab(text: 'На чтении'),
                Tab(text: 'В планах'),
                Tab(text: 'Прочитано'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                BooksFutureBuilder(status: 'reading'),
                BooksFutureBuilder(status: 'planned'),
                BooksFutureBuilder(status: 'completed'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80'),
          ),
          const SizedBox(height: 20),
          const Text('Анна', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('anna@example.com', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              await SupabaseService.signOut();
              await SharedPreferencesService.clearUserData();
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
  }
}