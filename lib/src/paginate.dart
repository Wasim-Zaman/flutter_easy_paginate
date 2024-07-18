import 'package:flutter/material.dart';

typedef FetchNextPage = Future<void> Function();

class Paginate extends StatefulWidget {
  final Widget child;
  final FetchNextPage onNextPage;
  final Widget? loader;
  final ScrollController scrollController;
  final Axis? scrollDirection;

  Paginate({
    super.key,
    required this.child,
    required this.onNextPage,
    this.loader,
    ScrollController? scrollController,
    this.scrollDirection,
  }) : scrollController = scrollController ?? ScrollController();

  @override
  State<Paginate> createState() => _PaginateState();
}

class _PaginateState extends State<Paginate> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (widget.scrollController.position.extentAfter < 200 && !_isLoading) {
      _fetchNextPage();
    }
  }

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
    widget.scrollController.removeListener(_onScroll);
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isLoading)
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: widget.loader ?? const CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
