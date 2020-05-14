import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncapod/providers/auth.dart';
import 'package:syncapod/providers/storage.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () => Provider.of<AuthProvider>(context, listen: false)
            .logout(Provider.of<StorageProvider>(context, listen: false)),
        child: Center(
          child: Text(
            'Logout',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
