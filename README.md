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
  flutter_easy_paginate: ^1.1.0
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_easy_paginate/flutter_easy_paginate.dart';

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

