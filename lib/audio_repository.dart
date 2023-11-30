import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/path_musics.dart';
import 'package:just_audio/just_audio.dart';

class MusicRepository {
  MusicRepository() {
    _initialBackground();
  }

  void play(AudioPlayer player) async {
    await player.seek(Duration.zero);
    player.play();
  }

  void handleAppLifecycleStateChanges(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      backgroundPlayer.play();
    } else {
      backgroundPlayer.stop();
    }
  }

  AudioPlayer backgroundPlayer = AudioPlayer();

  AudioPlayer bigButton = AudioPlayer()..setAsset(AppPathMusic.bigButton, preload: true);

  AudioPlayer littleButton = AudioPlayer()..setAsset(AppPathMusic.littleButton, preload: true);

  AudioPlayer pinButton = AudioPlayer()..setAsset(AppPathMusic.pinButton, preload: true);

  AudioPlayer popUp = AudioPlayer()..setAsset(AppPathMusic.popUp, preload: true);

  AudioPlayer popDown = AudioPlayer()..setAsset(AppPathMusic.popDown, preload: true);

  AudioPlayer checkBox = AudioPlayer()..setAsset(AppPathMusic.checkBox, preload: true);

  AudioPlayer copiedSingUp = AudioPlayer()..setAsset(AppPathMusic.copiedSingUp, preload: true);

  AudioPlayer copiedSingDown = AudioPlayer()..setAsset(AppPathMusic.copiedSingDown, preload: true);

  AudioPlayer screenChangeSlide = AudioPlayer()..setAsset(AppPathMusic.screenChangeSlide, preload: true);

  AudioPlayer dialogueAppear = AudioPlayer()..setAsset(AppPathMusic.dialogueAppear, preload: true);

  AudioPlayer dialogueDisappear = AudioPlayer()..setAsset(AppPathMusic.dialogueDisappear, preload: true);

  AudioPlayer mediumButton = AudioPlayer()..setAsset(AppPathMusic.mediumButton, preload: true);

  AudioPlayer eyeButton = AudioPlayer()..setAsset(AppPathMusic.eyeButton, preload: true);

  AudioPlayer openingLocker = AudioPlayer()..setAsset(AppPathMusic.openingLocker, preload: true);

  void _initialBackground() async{
    await backgroundPlayer.setAsset(AppPathMusic.backgroundFirstMusic);
    await backgroundPlayer.play();
    backgroundPlayer.playerStateStream.listen((event) async {
      print(event.processingState);

      if (event.processingState == ProcessingState.completed) {
        await backgroundPlayer.setAsset(AppPathMusic.backgroundLoopMusic);
        await backgroundPlayer.play();
      }
    });
  }
}
