import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/audio_repository.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold(
      {super.key,
      this.isBottomImage = false,
      required this.body,
      this.appBar,
      this.canPop = true,
      this.bottomResize = false,
      this.floatingActionButton,
      this.playAudio = true});

  final bool isBottomImage;
  final Widget body;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final bool bottomResize;
  final bool canPop;
  final bool playAudio;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  void initState() {
    super.initState();
    if (widget.playAudio) {
      final musicRepository = RepositoryProvider.of<MusicRepository>(context);

      musicRepository.play(musicRepository.screenChangeSlide);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return WillPopScope(
      onWillPop: () async {
        if (widget.canPop) {
          final musicRepository = RepositoryProvider.of<MusicRepository>(context);
          musicRepository.play(musicRepository.screenChangeSlide);
        }

        return widget.canPop;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.only(top: 15),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/gifts/background.gif"))),
          child: Stack(
            children: [
              widget.isBottomImage
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      top: size.height * 0.60,
                      child: SvgPicture.asset(
                        'assets/icons/bottom_bcg.svg',
                        width: size.width,
                        height: size.width * 0.89,
                        fit: BoxFit.fill,
                      ))
                  : Container(),
              SafeArea(
                child: Scaffold(
                  resizeToAvoidBottomInset: widget.bottomResize,
                  backgroundColor: Colors.transparent,
                  appBar: widget.appBar,
                  body: widget.body,
                  floatingActionButton: widget.floatingActionButton,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
