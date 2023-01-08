import 'package:flutter/material.dart';

class VoteScreen extends StatefulWidget {
  const VoteScreen({super.key});
  @override
  State<VoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('hi')),
    );
  }
}
