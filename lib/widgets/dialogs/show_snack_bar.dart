import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/audio_repository.dart';

class CustomScaffoldMessenger{
  static void show(SnackBar snackBar, BuildContext context){
    final musicRepository = RepositoryProvider.of<MusicRepository>(context);

    musicRepository.play(musicRepository.copiedSingUp);

    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar).closed.then((value) => musicRepository.play(musicRepository.copiedSingDown));
  }
}