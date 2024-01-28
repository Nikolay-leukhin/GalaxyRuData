import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/routes/routes.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/painters/white_circle.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';
import 'package:galaxy_rudata/widgets/text_fields/access_code_field.dart';

class SafeScreen extends StatefulWidget {
  const SafeScreen({super.key});

  @override
  State<SafeScreen> createState() => _SafeScreenState();
}

class _SafeScreenState extends State<SafeScreen> {
  final codeController = TextEditingController();

  List<int> activeRise = [];

  Future<void> startAnimation(Function(int) function) async {
    for (var i = 0; i < 5; i++) {
      activeRise = function(12);
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 240));
    }

    for (var i = 77; i >= 0; i--) {
      activeRise = [i];
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 13));
    }

    activeRise = List.generate(79, (index) => index);
    setState(() {});
    await Future.delayed(const Duration(seconds: 1));

    activeRise = List.generate(79, (index) => -1);
    setState(() {});
  }

  List<int> getRandomList(int n) {
    final random = Random();

    List<int> list = [];

    for (var i = 0; i < n; i++) {
      var temp = random.nextInt(77);

      while (list.contains(temp)) {
        temp = random.nextInt(77);
      }

      list.add(temp);
    }
    print(list);
    return list;
  }

  @override
  void initState() {
    codeController.text =
        RepositoryProvider.of<LandsRepository>(context).approve.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final repository = RepositoryProvider.of<LandsRepository>(context);

    final musicRepository = RepositoryProvider.of<AudioRepository>(context);
    return MainScaffold(
      isBottomImage: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 320,
                child: Text(
                  'Чтобы забрать ваш NFT-сертификат, введите код, полученный вами после прохождения квестов в виртуальном офисе Большого Росреестра',
                  style: AppTypography.font16w400,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  width: size.width * 0.82,
                  height: size.width * 0.86,
                  alignment: Alignment.center,
                  constraints:
                      const BoxConstraints(maxWidth: 350, maxHeight: 368),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/safe.png'),
                    fit: BoxFit.fitWidth,
                  )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: size.width * 0.12,
                      ),
                      Container(
                        width: size.width * 0.25,
                        height: size.width * 0.25,
                        constraints:
                            const BoxConstraints(maxWidth: 94, maxHeight: 94),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/safe1.png'),
                                fit: BoxFit.fitWidth)),
                        child: CustomPaint(
                          painter: WhiteCircle(colors: activeRise),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AccessCodeField(
                          // initialValue: repository.approve.toString(),
                          controller: codeController,
                          keyboardType: const TextInputType.numberWithOptions(),
                          hintText: 'Введите код',
                          width: size.width * 0.82 > 350
                              ? 225
                              : size.width * 0.528),
                    ],
                  )),
              CustomButton(
                  content: Text(
                    'Отправить код'.toUpperCase(),
                    style: AppTypography.font16w600,
                  ),
                  onTap: () async {
                    startAnimation((n) => getRandomList(n)).then((value) async {
                      await repository.verifyInviteCode(codeController.text);
                      Navigator.pushNamed(context, RouteNames.nftCertificate);
                    });
                  },
                  width: size.width * 0.528,
              audioPlayer: musicRepository.bigButton,),
            ],
          ),
        ),
      ),
      appBar: MainAppBar.backWallet(context),
    );
  }
}
