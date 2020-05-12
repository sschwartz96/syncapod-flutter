import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncapod/pages/subscriptions.dart';
import 'package:syncapod/providers/auth.dart';
import 'package:syncapod/providers/storage.dart';

enum Tab { Home, Subscriptions, Search, Settings }

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  final Map<Tab, GlobalKey<NavigatorState>> _tabKeys = {
    Tab.Home: GlobalKey<NavigatorState>(),
    Tab.Subscriptions: GlobalKey<NavigatorState>(),
    Tab.Search: GlobalKey<NavigatorState>(),
    Tab.Settings: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.deepPurple.withAlpha(50),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onTabTap,
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
          child: IndexedStack(
            index: _currentIndex,
            children: <Widget>[
              _home(context),
              SubscriptionsTab(
                navKey: _tabKeys[Tab.Subscriptions],
              ),
              _home(context),
              _home(context),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final storage =
                Provider.of<StorageProvider>(context, listen: false);
            final auth = Provider.of<AuthProvider>(context, listen: false);
            auth.logout(storage);
          },
          child: Icon(Icons.remove_circle_outline),
        ),
      ),
    );
  }

  /// onTabTap its trigger when bottom nav bar gets touched
  void _onTabTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static Widget _home(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
