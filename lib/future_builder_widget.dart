import 'package:flutter/material.dart';
import 'supabase_service.dart';
import 'book_model.dart';

class BooksFutureBuilder extends StatelessWidget {
  final String status;

  const BooksFutureBuilder({super.key, required this.status});

  Future<List<Book>> _fetchBooks() async {
    try {
      return await SupabaseService.getBooksByStatus(status);
    } catch (e) {
      throw Exception('Ошибка загрузки книг: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: _fetchBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Ошибка: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.menu_book, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  status == 'reading' ? 'Нет книг на чтении' :
                  status == 'planned' ? 'Нет книг в планах' :
                  'Нет прочитанных книг',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        final books = snapshot.data!;
        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(Icons.book),
                title: Text(book.title),
                subtitle: Text(book.author),
                trailing: Icon(
                  status == 'reading' ? Icons.play_arrow :
                  status == 'planned' ? Icons.schedule :
                  Icons.check_circle,
                  color: status == 'reading' ? Colors.blue :
                         status == 'planned' ? Colors.orange :
                         Colors.green,
                ),
              ),
            );
          },
        );
      },
    );
  }
}