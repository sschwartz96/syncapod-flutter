import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';
import 'providers/podcast.dart';
import 'providers/storage.dart';
import 'widgets/login.dart';
import 'widgets/home.dart';

void main() => runApp(Syncapod());

class Syncapod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StorageProvider>(
          create: (context) => StorageProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<PodcastProvider>(
          create: (context) => PodcastProvider(),
        )
      ],
      child: MaterialApp(
        title: 'syncapod',
        home: ShowPage(),
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          cursorColor: Colors.blue.shade900,
        ),
      ),
    );
  }
}

/// ShowPage determines whether to show login or home page
class ShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        final storage = Provider.of<StorageProvider>(context, listen: false);
        return FutureBuilder<bool>(
          future: Provider.of<AuthProvider>(context, listen: false)
              .isAuthorized(storage),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // expecting true or false to isAuthorized()
              if (snapshot.data)
                return HomePage();
              else
                return LoginPage();
            } else {
              return Scaffold(
                body: Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
