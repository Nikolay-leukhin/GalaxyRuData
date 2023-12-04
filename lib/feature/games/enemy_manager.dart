import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:galaxy_rudata/feature/games/enemy.dart';
import 'package:galaxy_rudata/feature/games/game.dart';

class EnemyManager extends Component with HasGameReference<SpaceShooter> {
  EnemyManager({required Sprite this.enemySprite}) : super() {
    timer = Timer(1, onTick: _spawnEnemy, repeat: true);
  }

  Random random = Random();
  Sprite enemySprite;
  void _spawnEnemy() {
    Vector2 postion = Vector2(
          random.nextDouble() * game.fixedResolution.x,
          0,
        ),
        initalSize = Vector2.all(64);

    postion.clamp(
        Vector2.zero() + initalSize, game.fixedResolution - initalSize);

    Enemy enemy = Enemy(
      sprite: enemySprite,
      size: initalSize,
      position: postion,
    );
    enemy.anchor = Anchor.center;
    game.add(enemy);
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    timer.start();
  }

  @override
  void onRemove() {
    // TODO: implement onRemove
    super.onRemove();
    timer.stop();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    timer.update(dt);

  }

  late Timer timer;
}
