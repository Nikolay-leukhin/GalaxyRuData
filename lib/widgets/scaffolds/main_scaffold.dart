import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, this.isBottomImage = false, required this.body, this.appBar});

  final bool isBottomImage;
  final Widget body;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: const EdgeInsets.only(top: 15),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/auth_background.png"))),
        child: Stack(
          children: [
            isBottomImage ? Container(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                  'assets/icons/bottom_back.svg',
                  width: size.width,
                  height: size.width * 0.89,
                )) : Container(),
            SafeArea(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: appBar,
                body: body,
              ),
            )
          ],
        ),
      ),
    );
  }
}
