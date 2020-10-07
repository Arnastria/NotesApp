import 'package:NotesApp/channel_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/channel',
      routes: {
        '/home': (context) => HomeScreen(),
        '/channel': (context) => ChannelScreen(),
      },
    );
  }
}
