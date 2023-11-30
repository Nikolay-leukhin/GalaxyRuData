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
    bigButton = AudioPlayer()..setAsset(AppPathMusic.bigButton, preload: true);

    littleButton = AudioPlayer()..setAsset(AppPathMusic.littleButton, preload: true);

    pinButton = AudioPlayer()..setAsset(AppPathMusic.pinButton, preload: true);

    popUp = AudioPlayer()..setAsset(AppPathMusic.popUp, preload: true);

    popDown = AudioPlayer()..setAsset(AppPathMusic.popDown, preload: true);

    checkBox = AudioPlayer()..setAsset(AppPathMusic.checkBox, preload: true);

    copiedSingUp = AudioPlayer()..setAsset(AppPathMusic.copiedSingUp, preload: true);

    copiedSingDown = AudioPlayer()..setAsset(AppPathMusic.copiedSingDown, preload: true);

    screenChangeSlide = AudioPlayer()..setAsset(AppPathMusic.screenChangeSlide, preload: true);

    dialogueAppear = AudioPlayer()..setAsset(AppPathMusic.dialogueAppear, preload: true);

    dialogueDisappear = AudioPlayer()..setAsset(AppPathMusic.dialogueDisappear, preload: true);

    mediumButton = AudioPlayer()..setAsset(AppPathMusic.mediumButton, preload: true);

    eyeButton = AudioPlayer()..setAsset(AppPathMusic.eyeButton, preload: true);

    openingLocker = AudioPlayer()..setAsset(AppPathMusic.openingLocker, preload: true);
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
