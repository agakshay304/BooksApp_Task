import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Book {
  final String name;
  final String company;

  Book({required this.name, required this.company});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      name: json['name'],
      company: json['company'],
    );
  }
}

class BooksListView extends StatelessWidget {
  const BooksListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: _fetchBooks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Book>? data = snapshot.data;
          return _booksListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Book>> _fetchBooks() async {
    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/f3feef1c-9bfa-43fd-b2a0-bbe9abadb4f6'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse["clients"];
      return data.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _booksListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].name, data[index].company);
        });
  }

  ListTile _tile(String title, String subtitle) => ListTile(
        title: Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
      );
}
