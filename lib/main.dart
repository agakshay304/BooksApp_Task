import 'package:flutter/material.dart';
import 'book_list_view.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listexample',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ListExample'),
        ),
        body: Center(child: BooksListView()),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
