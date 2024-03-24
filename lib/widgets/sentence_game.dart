import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer_clon/providers/game_state_provider.dart';
import 'package:typeracer_clon/utils/socket_client.dart';
import 'package:typeracer_clon/utils/socket_methods.dart';
import 'package:typeracer_clon/widgets/scoreboard.dart';

class SentenceGame extends StatefulWidget {
  const SentenceGame({super.key});

  @override
  State<SentenceGame> createState() => _SentenceGameState();
}

class _SentenceGameState extends State<SentenceGame> {
  final SocketMethods _socketMethods = SocketMethods();
  var playerMe = null;

  findPlayerMe(GameStateProvider game) {
    game.gameState['players'].forEach((player) {
      if (player['socketID'] == SocketClient.instance.socket!.id) {
        playerMe = player;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _socketMethods.updateGame(context);
  }

  Widget getTypedWords(words, player){
    var tempWords = words.sublist(0,player['currentWordIndex']);
    String typedWords = tempWords.join(' ');
    return Text(typedWords,
      style: const TextStyle(
        fontSize: 30,
        color: Color.fromRGBO(52, 235, 119, 1),
      ),
    );
  }

  Widget getCurrentWord(words, player){
    var tempWords = words[player['currentWordIndex']];
    return Text(tempWords,
      style: const TextStyle(
        fontSize: 30,
        decoration: TextDecoration.underline
      ),
    );
  }
  Widget getWordsTobeTyped(words, player){
    var tempWords = words.sublist(player['currentWordIndex'] + 1, words.length);
    String remainingWords = tempWords.join(' ');
    return Text(remainingWords,
      style: const TextStyle(
        fontSize: 30,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameStateProvider>(context);
    findPlayerMe(game);
    if(game.gameState['words'].length > playerMe['currentWordIndex']){
        return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Wrap(
          textDirection: TextDirection.ltr,
          children: [
            // typed words,
            getTypedWords(game.gameState['words'], playerMe),
            // current word

            getCurrentWord(game.gameState['words'], playerMe),
            // words to be typed

            getWordsTobeTyped(game.gameState['words'], playerMe)
          ],
        ),
      );
    }
    return const Scoreboard();
  }
}