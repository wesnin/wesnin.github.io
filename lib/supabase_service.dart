import 'package:supabase/supabase.dart';
import 'book_model.dart';

class SupabaseService {
  static final SupabaseClient client = SupabaseClient(
    'https://frvexfoezbscdbcvuxas.supabase.co/',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZydmV4Zm9lemJzY2RiY3Z1eGFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk3NDY4ODgsImV4cCI6MjA3NTMyMjg4OH0.XDr9MFxBMX0P42a4MwjstxtZeh_Caqdyrfpfr7d9ec8'
  );

  static Future<AuthResponse> signUp(String email, String password, String name) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
  }

  static Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  static User? getCurrentUser() {
    return client.auth.currentUser;
  }

  static Future<void> insertBook(Book book) async {
    await client
        .from('books')
        .insert(book.toJson());
  }

  static Future<List<Book>> getBooks() async {
    final response = await client
        .from('books')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((json) => Book.fromJson(json)).toList();
  }

  static Future<List<Book>> getBooksByStatus(String status) async {
    final response = await client
        .from('books')
        .select()
        .eq('status', status)
        .order('created_at', ascending: false);

    return (response as List).map((json) => Book.fromJson(json)).toList();
  }
}