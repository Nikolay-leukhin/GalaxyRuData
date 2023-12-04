import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/feature/games/game.dart';
import 'package:galaxy_rudata/routes/routes.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/popup/custom_popup.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/galaxy.jpg"))),
        child: Stack(
          children: [
            Positioned.fill(
                child: GameWidget(
              game: SpaceShooter(),
              overlayBuilderMap: {
                "MENU": (context, game) => CustomPopup(
                    label: "Вы успешно прошли квест!",
                    onTap: () {
                      Navigator.pushReplacementNamed(context, RouteNames.safe);
                    })
              },
            )),
            Align(
              alignment: Alignment.topRight,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    "assets/icons/back.svg",
                    width: 50,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
