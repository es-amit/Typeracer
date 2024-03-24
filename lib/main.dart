import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer_clon/providers/client_state_provider.dart';
import 'package:typeracer_clon/providers/game_state_provider.dart';
import 'package:typeracer_clon/screens/create_room_screen.dart';
import 'package:typeracer_clon/screens/game_screen.dart';
import 'package:typeracer_clon/screens/home_screen.dart';
import 'package:typeracer_clon/screens/join_room_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameStateProvider()),

        ChangeNotifierProvider(create: (context) => ClientStateProvider()),
      ],
      child: MaterialApp(
        title: 'Typeracer Tutorial',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        routes: {
          '/' : (context) => const HomeScreen(),
          '/create-room' :(context) => const CreateRoomScreen(),
          '/join-room' :(context) => const JoinRoomScreen(),
          '/game-screen' :(context)=> const GameScreen()
        },
      ),
    );
  }
}
