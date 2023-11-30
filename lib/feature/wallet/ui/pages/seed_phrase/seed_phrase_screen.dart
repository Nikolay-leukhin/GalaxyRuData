import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/feature/wallet/data/wallet_repository.dart';
import 'package:galaxy_rudata/feature/wallet/ui/widgets/seed_phrase_word.dart';
import 'package:galaxy_rudata/routes/routes.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';
import 'package:galaxy_rudata/widgets/snack_bars/success_snack_bar.dart';

class WalletSeedPhraseScreen extends StatefulWidget {
  final bool withContinueButton;

  const WalletSeedPhraseScreen({super.key, required this.withContinueButton});

  @override
  State<WalletSeedPhraseScreen> createState() => _WalletSeedPhraseScreenState();
}

class _WalletSeedPhraseScreenState extends State<WalletSeedPhraseScreen> {
  bool isSeedHidden = true;

  void changeSeedState() {
    setState(() {
      isSeedHidden = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final seedPhrase =
        context.read<WalletRepository>().wallet.mnemonic().split(" ");

    return MainScaffold(
      appBar: !widget.withContinueButton ? MainAppBar.back(context) : null,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 500),
            width: size.width * 0.69,
            child: Text(
              "По сид-фразе вы можете получить доступ к своему цифровому кошельку на других устройствах, надежно\nсохраните её!",
              style: AppTypography.font16w400.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: AppColors.darkBlue2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x6D31305A),
                    blurRadius: 11.27,
                    offset: Offset(0, 4.10),
                    spreadRadius: 3,
                  )
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 28, top: 21, bottom: 21),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(
                            seedPhrase.length,
                            (index) => SeedPhraseWordWidget(
                                  index: index + 1,
                                  word: seedPhrase[index].toLowerCase(),
                                )),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 24,
                      right: 21,
                      child: Image.asset(
                        "assets/images/polygon_watermark.png",
                        width: 93,
                        fit: BoxFit.fitWidth,
                      )),
                  Positioned(
                      right: 35,
                      top: 16,
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(1000),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(1000),
                            onTap: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: seedPhrase.join(" ")));

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(AppSnackBar.successSeedPhrase);
                            },
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(5),
                                child:
                                    SvgPicture.asset("assets/icons/copy.svg"))),
                      )),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Visibility(
                        visible: isSeedHidden,
                        maintainAnimation: true,
                        maintainState: true,
                        child: Container(
                          color: AppColors.primary,
                          child: Center(
                            child: Material(
                              color: AppColors.darkBlue,
                              borderRadius: BorderRadius.circular(10000),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10000),
                                onTap: () {
                                  changeSeedState();
                                },
                                child: Ink(
                                    padding: const EdgeInsets.all(19),
                                    child: SvgPicture.asset(
                                        'assets/icons/eye.svg')),
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          widget.withContinueButton
              ? Opacity(
                  opacity: isSeedHidden ? 0 : 1,
                  child: CustomButton(
                      content: Text(
                        "ДАЛЕЕ",
                        style: AppTypography.font16w600,
                      ),
                      onTap: () {
                        RepositoryProvider.of<WalletRepository>(context)
                            .setWalletConfirmState();
                        RepositoryProvider.of<AuthRepository>(context)
                            .refreshAuthState();
                        Navigator.popUntil(
                            context, ModalRoute.withName(RouteNames.root));
                      },
                      width: double.infinity),
                )
              : Container()
        ]),
      ),
    );
  }
}
