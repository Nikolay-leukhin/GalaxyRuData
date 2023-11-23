import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:trust_wallet_core_lib/protobuf/EOS.pb.dart';

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

    _animation = Tween<double>(begin: 1, end: 1.4).animate(
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
              Container(),
              Column(
                children: [
                  ScaleTransition(
                    scale: _animation,
                    child: Image.asset(
                      "assets/images/group.png",
                      fit: BoxFit.contain,
                      width: size.width * 0.5,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    "Вселенная Большого Росреестра",
                    style: AppTypography.font28w700,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ScaleTransition(
                    scale: _animation,
                    child: Container(
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
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/gifts/govnoi1-2.gif',
                  width: 70,
                  height: 70,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
