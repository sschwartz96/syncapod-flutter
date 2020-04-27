import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncapod/models/auth.dart';
import 'package:syncapod/models/storage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: SafeArea(child: Text('home page')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final storage = Provider.of<Storage>(context, listen: false);
          final auth = Provider.of<Auth>(context, listen: false);
          auth.logout(storage);
        },
        child: Icon(Icons.remove_circle_outline),
      ),
    ));
  }
}
