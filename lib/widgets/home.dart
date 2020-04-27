import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncapod/providers/auth.dart';
import 'package:syncapod/providers/storage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Function> tabs = [
    home,
    subscriptions,
    home,
    home,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('syncapod'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: onTabTap,
        items: [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Subscriptions'),
            icon: Icon(Icons.star),
          ),
          BottomNavigationBarItem(
            title: Text('Search'),
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            title: Text('Settings'),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: tabs[_currentIndex](context),
          builder: (context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data;
            }
            return Container(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
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

  void onTabTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static Future<Widget> home(BuildContext context) async {
    final username =
        await Provider.of<Storage>(context).read(Storage.key_username);
    return Container(child: Text('$username'));
  }

  static Future<Widget> subscriptions(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    return Container(child: Text('here are you subscriptions:'));
  }
}
