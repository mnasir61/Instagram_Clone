import 'package:flutter/material.dart';

class RefreshIndicatorWidget extends StatefulWidget {
  final Widget child;

  const RefreshIndicatorWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<RefreshIndicatorWidget> createState() => _RefreshIndicatorWidgetState();
}

class _RefreshIndicatorWidgetState extends State<RefreshIndicatorWidget> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  bool _isRefreshing = false;

  Future<Null> _refresh() async {
    setState(() {
      _isRefreshing = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isRefreshing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      color: Colors.white,
      child: widget.child,
    );
  }
}
