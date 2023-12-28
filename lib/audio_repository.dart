import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/path_musics.dart';
import 'package:just_audio/just_audio.dart';

class AudioRepository {
  AudioRepository() {
    // if (!kDebugMode) {
    _initialPlayers();
    _initialBackground();
    // }
  }

  late Future initialized;

  void play(AudioPlayer player) async {
    if (player.position != Duration.zero) await player.seek(Duration.zero);
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

  AudioPlayer safe = AudioPlayer();

  List<AudioPlayer> get players => [
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
        safe,
      ];

  void _initialBackground() async {
    await backgroundPlayer.setAsset(AppPathMusic.backgroundFirstMusic);
    await backgroundPlayer.play();
    backgroundPlayer.playerStateStream.listen((event) async {
      log(event.processingState.toString());

      if (event.processingState == ProcessingState.completed) {
        await backgroundPlayer.setAsset(AppPathMusic.backgroundLoopMusic);
        await backgroundPlayer.play();
      }
    });
  }

  void _initialPlayers() async {
    bigButton.setAsset(AppPathMusic.bigButton, preload: true);
    littleButton.setAsset(AppPathMusic.littleButton, preload: true);
    pinButton.setAsset(AppPathMusic.pinButton, preload: true);
    popUp.setAsset(AppPathMusic.popUp, preload: true);
    popDown.setAsset(AppPathMusic.popDown, preload: true);
    checkBox.setAsset(AppPathMusic.checkBox, preload: true);
    copiedSingUp.setAsset(AppPathMusic.copiedSingUp, preload: true);
    copiedSingDown.setAsset(AppPathMusic.copiedSingDown, preload: true);
    screenChangeSlide.setAsset(AppPathMusic.screenChangeSlide, preload: true);
    screenChangeSlide.setAsset(AppPathMusic.screenChangeSlide, preload: true);
    dialogueAppear.setAsset(AppPathMusic.dialogueAppear, preload: true);
    dialogueDisappear.setAsset(AppPathMusic.dialogueDisappear, preload: true);
    mediumButton.setAsset(AppPathMusic.mediumButton, preload: true);
    safe.setAsset(AppPathMusic.safe, preload: true);

    List<Future> futures = [];

    for (AudioPlayer player in players) {
      futures.add(_startPlayer(player));
    }

    initialized = Future.wait(futures);
  }

  Future _startPlayer(AudioPlayer player) async {
    await player.setVolume(0);
    await player.setSpeed(100000000);
    await player.play();
    await player.stop();
    await player.setSpeed(1);
    await player.setVolume(1);
  }
}
