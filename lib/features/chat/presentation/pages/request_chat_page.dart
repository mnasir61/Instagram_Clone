import 'package:flutter/material.dart';

class RequestChatPage extends StatelessWidget {
  const RequestChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Text('Request Chat Page'),
        ),
      ),
    );
  }
}
