import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:syncapod/constants.dart';
import 'package:syncapod/pages/home.dart';
import 'package:syncapod/pages/login.dart';
import 'package:syncapod/providers/audio.dart';
import 'models/user.dart';
import 'providers/user.dart';
import 'providers/auth.dart';
import 'providers/podcast.dart';
import 'providers/storage.dart';

void main() => runApp(Syncapod());

class Syncapod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StorageProvider>(
          create: (context) => StorageProvider(),
        ),
        Provider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<PodcastProvider>(
          create: (context) => PodcastProvider(),
        ),
        Provider<AudioProvider>(
          create: (context) => AudioProvider(AudioPlayer()),
        )
      ],
      child: MaterialApp(
        title: 'syncapod',
        home: ShowPage(),
        theme: ThemeData(
          // primaryColor: Colors.deepPurple.shade700,
          // canvasColor: Colors.grey.shade900,
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
    // Setup consumer to be notified when auth status changes
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        // grab our storage to save and read data
        final storage = Provider.of<StorageProvider>(context, listen: false);
        // future builder is needed to check authorization status
        return FutureBuilder<User>(
          // future checks if we have a token and authorizes it with the server
          future: Provider.of<AuthProvider>(context, listen: false)
              .isAuthorized(storage),
          // builder is where we return our widget
          builder: (context, AsyncSnapshot<User> snapshot) {
            // if the app is still checking auth status
            if (snapshot.connectionState == ConnectionState.done) {
              // our snapshot.data is true or false from isAuthorized()
              if (snapshot.data != null) {
                // make sure our UserProvider gets our user info
                Provider.of<UserProvider>(context, listen: false)
                    .setUser(snapshot.data);
                return BottomNav();
              } else {
                return LoginPage();
              }
            } else {
              // show circular loading
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
