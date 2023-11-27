import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold(
      {super.key,
      this.isBottomImage = false,
      required this.body,
      this.appBar,
      this.canPop = true,
        this.bottomResize = false,
      this.floatingActionButton});

  final bool isBottomImage;
  final Widget body;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final bool bottomResize;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return WillPopScope(
      onWillPop: () async => canPop,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.only(top: 15),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/gifts/background.png"))),
          child: Stack(
            children: [
              isBottomImage
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
                  resizeToAvoidBottomInset: bottomResize,
                  backgroundColor: Colors.transparent,
                  appBar: appBar,
                  body: body,
                  floatingActionButton: floatingActionButton,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
