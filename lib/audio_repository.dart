import 'package:galaxy_rudata/utils/path_musics.dart';
import 'package:just_audio/just_audio.dart';

class MusicRepository {
  AudioPlayer bigButton = AudioPlayer();

  AudioPlayer littleButton = AudioPlayer();

  AudioPlayer pinButton = AudioPlayer();

  AudioPlayer popUp = AudioPlayer();

  AudioPlayer popDown = AudioPlayer();

  AudioPlayer checkBox = AudioPlayer();

  AudioPlayer copiedSingUp = AudioPlayer();

  AudioPlayer copiedSingDown = AudioPlayer();

  AudioPlayer screenChangeSlide = AudioPlayer();

  AudioPlayer dialogueAppear = AudioPlayer();

  AudioPlayer dialogueDisappear = AudioPlayer();

  AudioPlayer mediumButton = AudioPlayer();

  AudioPlayer eyeButton = AudioPlayer();

  AudioPlayer openingLocker = AudioPlayer();

  Future<void> initActionMusic() async {
    bigButton = AudioPlayer()..setAsset(AppPathMusic.bigButton);

    littleButton = AudioPlayer()..setAsset(AppPathMusic.littleButton);

    pinButton = AudioPlayer()..setAsset(AppPathMusic.pinButton);

    popUp = AudioPlayer()..setAsset(AppPathMusic.popUp);

    popDown = AudioPlayer()..setAsset(AppPathMusic.popDown);

    checkBox = AudioPlayer()..setAsset(AppPathMusic.checkBox);

    copiedSingUp = AudioPlayer()..setAsset(AppPathMusic.copiedSingUp);

    copiedSingDown = AudioPlayer()..setAsset(AppPathMusic.copiedSingDown);

    screenChangeSlide = AudioPlayer()..setAsset(AppPathMusic.screenChangeSlide);

    dialogueAppear = AudioPlayer()..setAsset(AppPathMusic.dialogueAppear);

    dialogueDisappear = AudioPlayer()..setAsset(AppPathMusic.dialogueDisappear);

    mediumButton = AudioPlayer()..setAsset(AppPathMusic.mediumButton);

    eyeButton = AudioPlayer()..setAsset(AppPathMusic.eyeButton);

    openingLocker = AudioPlayer()..setAsset(AppPathMusic.openingLocker);
  }

  List<AudioPlayer> players() => [
        bigButton,
        littleButton,
        pinButton,
        popUp,
        popDown,
        checkBox,
        copiedSingUp,
        copiedSingDown,
        screenChangeSlide,
        dialogueAppear,
        dialogueDisappear,
        mediumButton,
        eyeButton,
        openingLocker,
      ];

  Future<void> play(AudioPlayer player) async {
    player.play().then((value) async {
      await player.seek(const Duration(seconds: 0));
    });
  }
}
