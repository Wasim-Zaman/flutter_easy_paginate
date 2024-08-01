import 'package:flutter/material.dart';
import 'package:flutter_easy_paginate/flutter_easy_paginate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Easy Paginate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyListView(),
    );
  }
}

class MyListView extends StatefulWidget {
  const MyListView({super.key});

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  final List<String> _items = List.generate(20, (index) => 'Item $index');
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  Future<void> _fetchNextPage() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _items.addAll(
          List.generate(20, (index) => 'Item ${_items.length + index}'));
      page++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: const Text('Paginate Example'),
        backgroundColor: Colors.blue,
        primary: true,
      ),
      body: Paginate(
        scrollController: _scrollController,
        onNextPage: _fetchNextPage,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_items[index]),
            );
          },
        ),
      ),
    );
  }
}
