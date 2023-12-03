import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'game.dart';

class Player extends SpriteComponent with HasGameReference<SpaceShooter> {
  Player({Sprite? sprite, Vector2? position, Vector2? size})
      : super(sprite: sprite, position: position, size: size);

  Vector2 _moveDirection = Vector2.zero();
  static const double _speed = 300;

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    this.position += _moveDirection.normalized() * _speed * dt;
    position.clamp(
      Vector2.zero(),
      game.fixedResolution - size,
    );
  }

  void setMoveDirection(Vector2 newMoveDirection) {
    _moveDirection = newMoveDirection;
  }
}
