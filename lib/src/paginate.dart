import 'package:flutter/material.dart';

/// A type definition for the function that fetches the next page of data.
typedef FetchNextPage = Future<void> Function();

/// A widget that provides automatic pagination by calling the [onNextPage]
/// callback when the user scrolls near the bottom of the list.
class Paginate extends StatefulWidget {
  /// The child widget that displays the content to be paginated.
  final Widget child;

  /// The callback function to fetch the next page of data.
  final FetchNextPage onNextPage;

  /// An optional loader widget to display while fetching the next page.
  final Widget? loader;

  /// The scroll controller for the list. If not provided, a default scroll controller is used.
  final ScrollController scrollController;

  /// The scroll direction for the list. Defaults to vertical.
  final Axis scrollDirection;

  /// Creates a [Paginate] widget.
  ///
  /// The [child] and [onNextPage] parameters are required.
  Paginate({
    super.key,
    required this.child,
    required this.onNextPage,
    this.loader,
    ScrollController? scrollController,
    this.scrollDirection = Axis.vertical,
  }) : scrollController = scrollController ?? ScrollController();

  @override
  State<Paginate> createState() => _PaginateState();
}

class _PaginateState extends State<Paginate> {
  /// Indicates whether the widget is currently loading the next page.
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Add the scroll listener to detect when the user scrolls near the bottom of the list.
    widget.scrollController.addListener(_onScroll);
  }

  /// Called when the user scrolls the list. If the user scrolls near the bottom
  /// and the widget is not already loading, it fetches the next page.
  void _onScroll() {
    if (widget.scrollController.position.extentAfter < 200 && !_isLoading) {
      _fetchNextPage();
    }
  }

  /// Fetches the next page of data by calling the [onNextPage] callback.
  /// Sets the loading state before and after the fetch.
  Future<void> _fetchNextPage() async {
    setState(() {
      _isLoading = true;
    });

    await widget.onNextPage();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // Remove the scroll listener and dispose the scroll controller when the widget is disposed.
    widget.scrollController.removeListener(_onScroll);
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // The child widget that displays the content to be paginated.
        Expanded(child: widget.child),
        // Display the loader widget if the widget is currently loading.
        if (_isLoading)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Center(
                  child: widget.loader ?? const CircularProgressIndicator(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
