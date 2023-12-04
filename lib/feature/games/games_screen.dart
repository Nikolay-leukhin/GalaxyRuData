import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/feature/games/game.dart';
import 'package:galaxy_rudata/feature/lands/bloc/create_code/create_code_cubit.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/routes/routes.dart';
import 'package:galaxy_rudata/utils/utils.dart';
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
                "MENU": (context, game) => GamePopup()
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

class GamePopup extends StatefulWidget {
  const GamePopup({super.key});

  @override
  State<GamePopup> createState() => _GamePopupState();
}

class _GamePopupState extends State<GamePopup> {
  @override
  void initState() {
    context.read<CreateCodeCubit>().loadCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final musicRepository = RepositoryProvider.of<AudioRepository>(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.sizeOf(context).width - 32,
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
              color: AppColors.darkBlue1,
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<CreateCodeCubit, CreateCodeState>(
                builder: (context, state) {
                  if (state is CreateCodeLoading) {
                    return Text(
                      "Генерируем для вас секретный код...",
                      textAlign: TextAlign.center,
                      style: AppTypography.font16w400
                          .copyWith(color: Colors.white),
                    );
                  } else if (state is CreateCodeSuccess) {
                    return Text(
                      "Ваш код: ${context.read<LandsRepository>().approve}\nКод вставится автоматически.",
                      textAlign: TextAlign.center,
                      style: AppTypography.font16w400
                          .copyWith(color: Colors.white),
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 32,
              ),
              CustomButton(
                  content: Text("OK".toUpperCase(),
                      style: AppTypography.font16w600
                          .copyWith(color: Colors.white)),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, RouteNames.safe);
                  },
                  width: double.infinity,
                  audioPlayer: musicRepository.mediumButton)
            ],
          ),
        ),
      ),
    );
  }
}
