import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_rudata/feature/games/game.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: SpaceShooter());
  }
}