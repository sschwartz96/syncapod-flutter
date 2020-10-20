import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncapod/constants.dart';
import 'package:syncapod/pages/home.dart';
import 'package:syncapod/pages/login.dart';
import 'package:syncapod/protos/auth.pb.dart';
import 'package:syncapod/providers/auth.dart';
import 'package:syncapod/providers/podcast.dart';
import 'package:syncapod/providers/storage.dart';
import 'package:syncapod/providers/user.dart';

void main() => runApp(Syncapod());

class Syncapod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AudioServiceWidget(
      child: MultiProvider(
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
            create: (context) => PodcastProvider("no_token_yet"),
          ),
        ],
        child: MaterialApp(
          title: 'syncapod',
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: purple,
            accentColor: Colors.deepPurpleAccent,
            canvasColor: darkGrey,
            fontFamily: 'Quicksand',
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontFamily: 'Quicksand',
              ),
              headline6: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
              button: TextStyle(
                fontSize: 24,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
              ),
            ),
            buttonColor: purple,
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.deepPurple,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
            ),
            inputDecorationTheme: InputDecorationTheme(
              fillColor: Colors.deepPurple,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          home: ShowPage(),
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
        return FutureBuilder<AuthRes>(
          // future checks if we have a token and authorizes it with the server
          future: Provider.of<AuthProvider>(context, listen: false)
              .authorize(storage),
          // builder returns widget either BottomNav(homepage) or LoginPage
          builder: (context, AsyncSnapshot<AuthRes> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // if the data has session key and user object means we are authorized
              if (snapshot.hasData &&
                  snapshot.data.sessionKey.length > 0 &&
                  snapshot.data.user != null) {
                // make sure we setup our providers
                _setupAuthorizedProviders(context, snapshot.data);
                return BottomNav();
              } else {
                return LoginPage();
              }
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

void _setupAuthorizedProviders(BuildContext context, AuthRes authRes) {
  Provider.of<UserProvider>(context, listen: false).setUser(authRes.user);
  Provider.of<PodcastProvider>(context, listen: false)
      .setToken(authRes.sessionKey);
}
