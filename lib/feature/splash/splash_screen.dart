import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 1, end: 1.38).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("assets/images/bgg.png"))),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: SizedBox(
                      height: 100,
                      child: ScaleTransition(
                        scale: _animation,
                        child: Image.asset(
                          "assets/images/group.png",
                          fit: BoxFit.contain,
                          width: size.width * 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Text(
                    "Вселенная Большого Росреестра",
                    style: AppTypography.font28w600,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ScaleTransition(
                    scale: _animation,
                    child: Container(
                      width: size.width * 0.8,
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Image.asset(
                        "assets/images/planet.png",
                        fit: BoxFit.contain,
                        width: size.width * 0.8,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/gifts/govnoi1-2.gif',
                      width: 70,
                      height: 70,
                    ),
                  ),
                  Text(
                    'Переносимся во Вселенной',
                    textAlign: TextAlign.center,
                    style: AppTypography.font14w400.copyWith(
                      shadows: [
                        const BoxShadow(
                          offset: Offset.zero,
                          blurRadius: 10,
                          color: Colors.white
                        )
                      ]
                    )
                  ),
                  SizedBox(height: 20,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
