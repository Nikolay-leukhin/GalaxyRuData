import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/feature/games/bullet.dart';
import 'package:galaxy_rudata/feature/games/game.dart';

class Enemy extends SpriteComponent
    with HasGameReference<SpaceShooter>, CollisionCallbacks {
  Enemy({Sprite? sprite, Vector2? position, Vector2? size})
      : super(sprite: sprite, position: position, size: size);

  double _speed = 250;

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * _speed * dt;
    if (position.y > game.fixedResolution.y) {
      removeFromParent();
    }
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    final shape = CircleHitbox.relative(
      0.8,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    )..renderShape = true;
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bullet) {
      game.player.score += 1;
      removeFromParent();

      if (game.player.score == 50) {
        game.pauseEngine();
        game.overlays.add("MENU");
      }
    }
  }
}
