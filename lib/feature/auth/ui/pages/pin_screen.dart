import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/feature/auth/ui/widgets/pin_code_indicator.dart';
import 'package:galaxy_rudata/feature/auth/ui/widgets/pin_num_tab.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  List<int> pinData = [];
  final pinKeyboard = [1, 2, 3, 4, 5, 6, 7, 8, 9, "", 0, "del"];

  void onNumTabTap(int index) async {
    if (pinData.length < 4) {
      pinData.add(index);
    }

    if (pinData.length == 4) {
      print(pinData);
      context.read<AuthRepository>().typedUserPinCode = List.from(pinData);
      pinData.clear();
      Navigator.of(context).pushNamed(RouteNames.authPinRepeat);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
                image: AssetImage("assets/images/auth_background.png"))),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: MainAppBar(
              context,
              isAction: false,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 260,
                    child: Text(
                      "Придумайте пин-код\nдля своего цифрового кошелька",
                      textAlign: TextAlign.center,
                      style: AppTypography.font16w400
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    height: size.height * 0.078,
                    constraints: const BoxConstraints(maxHeight: 63),
                  ),
                  SizedBox(
                    width: 216,
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          4,
                          (index) => PinCodeIndicatorItem(
                            isActive: index < pinData.length,
                          ),
                        )),
                  ),
                  Container(
                    height: size.height * 0.089,
                    constraints: const BoxConstraints(maxHeight: 90),
                  ),
                  Container(
                    width: size.width * 0.73,
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PinNumTab(
                              content: Text(
                                1.toString(),
                                style: AppTypography.font24w700
                                    .copyWith(color: Colors.white),
                              ),
                              onTap: () => onNumTabTap(1),
                            ),
                            PinNumTab(
                              content: Text(
                                2.toString(),
                                style: AppTypography.font24w700
                                    .copyWith(color: Colors.white),
                              ),
                              onTap: () => onNumTabTap(2),
                            ),
                            PinNumTab(
                              content: Text(
                                3.toString(),
                                style: AppTypography.font24w700
                                    .copyWith(color: Colors.white),
                              ),
                              onTap: () => onNumTabTap(3),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PinNumTab(
                              content: Text(
                                4.toString(),
                                style: AppTypography.font24w700
                                    .copyWith(color: Colors.white),
                              ),
                              onTap: () => onNumTabTap(4),
                            ),
                            PinNumTab(
                              content: Text(
                                5.toString(),
                                style: AppTypography.font24w700
                                    .copyWith(color: Colors.white),
                              ),
                              onTap: () => onNumTabTap(5),
                            ),
                            PinNumTab(
                              content: Text(
                                6.toString(),
                                style: AppTypography.font24w700
                                    .copyWith(color: Colors.white),
                              ),
                              onTap: () => onNumTabTap(6),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PinNumTab(
                              content: Text(
                                7.toString(),
                                style: AppTypography.font24w700
                                    .copyWith(color: Colors.white),
                              ),
                              onTap: () => onNumTabTap(7),
                            ),
                            PinNumTab(
                              content: Text(
                                8.toString(),
                                style: AppTypography.font24w700
                                    .copyWith(color: Colors.white),
                              ),
                              onTap: () => onNumTabTap(8),
                            ),
                            PinNumTab(
                              content: Text(
                                9.toString(),
                                style: AppTypography.font24w700
                                    .copyWith(color: Colors.white),
                              ),
                              onTap: () => onNumTabTap(9),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              constraints: const BoxConstraints(maxWidth: 125),
                              width: size.width * 0.189,
                            ),
                            PinNumTab(
                              content: Text(
                                0.toString(),
                                style: AppTypography.font24w700
                                    .copyWith(color: Colors.white),
                              ),
                              onTap: () => onNumTabTap(0),
                            ),
                            PinNumTab(
                              onTap: () {
                                if (pinData.isNotEmpty) {
                                  pinData.removeLast();
                                }
                                setState(() {});
                              },
                              content: SvgPicture.asset(
                                'assets/icons/delete.svg',
                                width: 24,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
