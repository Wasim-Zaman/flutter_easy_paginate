# Flutter Easy Paginate

![Flutter Easy Paginate](https://img.shields.io/badge/flutter--easy--paginate-v1.1.0-blue)
![Platform](https://img.shields.io/badge/platform-flutter-blue)
![License](https://img.shields.io/badge/license-MIT-green)

A Flutter package for easy pagination, allowing seamless integration with various scrollable widgets like `ListView`, `GridView`, `Column`, etc.

## Features

- **Seamless Pagination:** Automatically fetch the next page of data when reaching the end of the scroll.
- **Customizable Loader:** Display a default loader or provide your own custom loader widget.
- **Flexible Scroll Direction:** Support for both vertical and horizontal scrolling.

## Installation

Add the following line to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_easy_paginate: ^1.2.0
```

## Usage

```dart
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
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        primary: true,
      ),
      body: Paginate(
        scrollController: _scrollController,
        onNextPage: _fetchNextPage,
        loader: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Loading...",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        child: ListView.builder(
          itemCount: _items.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Text(
                    _items[index].split(' ')[1],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  _items[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  'This is a description of the item.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


```

## Example

https://github.com/user-attachments/assets/a10f5872-9aa4-4962-8005-88b562ea9524

## Custom Loader

```dart
Paginate(
  scrollController: _scrollController,
  onNextPage: _fetchNextPage,
  loader: const Text("Loading..."),
  child: ListView.builder(
    controller: _scrollController,
    itemCount: _items.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(_items[index]),
      );
    },
  ),
);
```

## Example

https://github.com/user-attachments/assets/55c1ec9a-f8ec-47a9-8f37-4c1c15a38356
