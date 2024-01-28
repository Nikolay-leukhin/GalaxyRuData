import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:galaxy_rudata/feature/games/enemy.dart';
import 'package:galaxy_rudata/feature/games/game.dart';

class Bullet extends SpriteComponent with CollisionCallbacks {
  Bullet({Sprite? sprite, Vector2? position, Vector2? size})
      : super(
          sprite: sprite,
          position: position,
          size: size,
        );

  double _speed = 400;

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    final shape = RectangleHitbox();
    add(shape);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    position += Vector2(0, -1) * _speed * dt;
    if (position.y < 0) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      removeFromParent();
    }
  }
}

class BulletShooter extends Component with HasGameReference<SpaceShooter> {
  BulletShooter({required Sprite this.bullet}) : super() {
    timer = Timer(0.5, onTick: _shootBullet, repeat: true);
  }

  Sprite bullet;
  late Timer timer;

  void _shootBullet() {
    Bullet bullet = Bullet(
        sprite: this.bullet,
        size: Vector2(14, 39.67),
        position: game.player.position.clone() + Vector2(32, 0));
    bullet.anchor = Anchor.center;
    game.add(bullet);
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
}
