import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncapod/models/subscription.dart';
import 'package:syncapod/providers/auth.dart';
import 'package:syncapod/providers/podcast.dart';
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
          final storage = Provider.of<StorageProvider>(context, listen: false);
          final auth = Provider.of<AuthProvider>(context, listen: false);
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
    final username = await Provider.of<StorageProvider>(context)
        .read(StorageProvider.key_username);
    return Container(child: Text('$username'));
  }

  static Future<Widget> subscriptions(BuildContext context) async {
    return FutureBuilder<List<Subscription>>(
      future: getSubs(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        return snapshot.data == null
            ? Text('no subs')
            : ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  print('snapshot data: ${snapshot.data[index].podcast.title}');
                  return ListTile(
                    title: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            snapshot.data[index].podcast.image.url,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 8.0),
                            child:
                                Text('${snapshot.data[index].podcast.title}')),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }

  static Future<List<Subscription>> getSubs(BuildContext context) async {
    final token = await Provider.of<StorageProvider>(context, listen: false)
        .read(StorageProvider.key_access_token);
    return await Provider.of<PodcastProvider>(context, listen: false)
        .getSubscriptions(token);
  }
}
