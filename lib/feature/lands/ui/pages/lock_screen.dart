import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/feature/lands/bloc/invite_codes/invite_codes_cubit.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/popup/custom_popup.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';
import 'package:galaxy_rudata/widgets/text_fields/access_code_field.dart';

// const String _lockMessage =
//     'Введите персональный код доступа, чтобы забронировать себе жилье во Вселенной Большого Росреестра. Один код дает возможность бронирования одного жилья.';
const String _lockMessage =
    'Введите код доступа «Росреестр» (без кавычек), чтобы оформить себе жилье во Вселенной Большого Росреестра.';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final codeController = TextEditingController();

  double turn = 0;
  double top = 25;

  final rotationDuration = const Duration(milliseconds: 900);
  final moveDuration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final musicRepository = RepositoryProvider.of<AudioRepository>(context);
    final size = MediaQuery.sizeOf(context);
    final field = Center(
      child: Padding(
        padding: EdgeInsets.only(
            top: size.width * 0.88 < 450 ? size.width * 0.88 / 2.5 : 180),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 200),
          child: AccessCodeField(
              controller: codeController,
              keyboardType: TextInputType.text,
              hintText: 'Введите код',
              width: size.width - 100),
        ),
      ),
    );

    openLock() {
      musicRepository.play(musicRepository.openingLocker);
      setState(() {
        top = 0;
      });
      Future.delayed(moveDuration).then((value) {
        setState(() {
          turn = 0.13;
        });
      });
    }

    return BlocListener<InviteCodesCubit, InviteCodesState>(
      listener: (context, state) {
        if (state is LoadingState) {
          Dialogs.showModal(
              context,
              const Center(
                child: CircularProgressIndicator.adaptive(),
              ));
        } else if (state is UseInviteCodeSuccess) {
          Dialogs.hide(context);

          musicRepository.play(musicRepository.openingLocker);
          openLock();
        } else if (state is UseInviteCodeFail) {
          Dialogs.hide(context);

          String wasUsedMessage = "Извините, данный код уже был использован";
          String invalidCodeMessage =
              "Некорректный код, пожалуйста, попробуйте еще раз";

          Dialogs.showModal(
              context,
              CustomPopup(
                label: state.e is CodeWasUsedException
                    ? wasUsedMessage
                    : invalidCodeMessage,
                onTap: () {
                  Dialogs.hide(context);
                },
              ));
        }
      },
      child: MainScaffold(
        canPop: false,
        bottomResize: true,
        isBottomImage: true,
        appBar: MainAppBar.logoutWallet(
          context,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MediaQuery.of(context).viewInsets.bottom == 0
                    ? Container(
                        width: size.width * 0.69,
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: Text(
                          _lockMessage,
                          style: size.width > 300
                              ? AppTypography.font16w400
                              : AppTypography.font14w400,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(),
                Container(
                  width: size.width * 0.725,
                  height: size.width,
                  constraints:
                      const BoxConstraints(maxWidth: 330, maxHeight: 450),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          'assets/images/lock/back.png',
                        ),
                      ),
                      AnimatedPositioned(
                        top: top,
                        left:
                            size.width * 0.725 < 300 ? size.width * 0.108 : 50,
                        duration: moveDuration,
                        child: AnimatedRotation(
                          alignment: const Alignment(0.2, 0.3),
                          curve: Curves.decelerate,
                          turns: turn,
                          duration: rotationDuration,
                          child: Container(
                            constraints: const BoxConstraints(
                                maxWidth: 230, maxHeight: 250),
                            height: size.width * 0.48,
                            width: size.width * 0.51,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/lock/lock.png'),
                                    fit: BoxFit.fitWidth)),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          'assets/images/lock/front.png',
                        ),
                      ),
                      field
                    ],
                  ),
                ),
                CustomButton(
                  content: Text(
                    'Отправить код'.toUpperCase(),
                    style: AppTypography.font16w600,
                  ),
                  onTap: () {
                    if (codeController.text.isNotEmpty) {
                      context.read<InviteCodesCubit>().useInviteCode(
                          codeController.text.trim(),
                          moveDuration + rotationDuration);
                    }
                  },
                  width: double.infinity,
                  audioPlayer: musicRepository.bigButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
