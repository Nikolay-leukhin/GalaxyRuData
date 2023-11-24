import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/feature/auth/bloc/auth/auth_cubit.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/utils/validators.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/popup/custom_popup.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';
import 'package:galaxy_rudata/widgets/text_fields/base_text_form_field.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final int codeSendDuration = 60;
  int currentRemainingTime = 0;

  bool isConditionsAccepted = false;

  bool errorEmailField = false;
  bool errorCodeField = false;
  bool withErrorCheckBox = false;

  void changeCheckboxValue(bool value) {
    setState(() {
      isConditionsAccepted = value;
    });
  }

  void processTimerStart() async {
    while (currentRemainingTime > 0) {
      await Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            currentRemainingTime -= 1;
          });
        }
      });
    }
  }

  void sendAuthCode() async {
    errorEmailField = Validator.emailValidator(emailController.text) is String;
    setState(() {});

    if (!errorEmailField && currentRemainingTime == 0) {
      currentRemainingTime = 60;
      context.read<AuthRepository>().sendEmailCode(emailController.text);
      processTimerStart();
    }
  }

  bool checkFieldsState() {
    errorEmailField = Validator.emailValidator(emailController.text) is String;
    errorCodeField = Validator.code(codeController.text) is String;
    withErrorCheckBox = !isConditionsAccepted;
    setState(() {});

    return !errorCodeField && !errorEmailField && isConditionsAccepted;
  }

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
         if (state is AuthFailState) {
          Dialogs.hide(context);
          Dialogs.showModal(
              context,
              CustomPopup(
                label: "Неверный код",
                onTap: () {
                  Dialogs.hide(context);
                },
              ));
        } else if (state is AuthSuccessState) {
          Dialogs.hide(context);
        } else if (state is AuthLoadingState) {
          Dialogs.showModal(
              context,
              const Center(
                child: CircularProgressIndicator.adaptive(),
              ));
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: MainScaffold(
          canPop: false,
          // bottomResize: true,
          appBar: MainAppBar.onlyLogo(
            context,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Авторизация",
                  style: AppTypography.font24w700
                      .copyWith(color: Colors.white),
                ),
                Container(
                  height: size.height * 0.059,
                  constraints: const BoxConstraints(maxHeight: 48),
                ),
                BaseTextFormField(
                  withError: errorEmailField,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "E-mail адрес",
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 60,
                  child: Stack(
                    children: [
                      Positioned(
                        child: BaseTextFormField(
                          withError: errorCodeField,
                          padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 22)
                              .copyWith(right: 120),
                          controller: codeController,
                          keyboardType: TextInputType.number,
                          hintText: "Код",
                        ),
                      ),
                      currentRemainingTime == 0
                          ? Positioned(
                              right: 0,
                              child: CustomButton(
                                  content: Text("Отправить".toUpperCase(),
                                      style: AppTypography.font16w600
                                          .copyWith(color: Colors.white)),
                                  onTap: () {
                                    sendAuthCode();
                                  },
                                  width: 120),
                            )
                          : Positioned(
                              right: 0,
                              child: CustomButton(
                                  content: Text(
                                      "${currentRemainingTime} СЕКУНД"
                                          .toUpperCase(),
                                      style: AppTypography.font16w600
                                          .copyWith(color: Colors.white)),
                                  onTap: () {
                                    sendAuthCode();
                                  },
                                  width: 120),
                            )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        border: Border.all(
                            width: 2,
                            color: !withErrorCheckBox
                                ? AppColors.silver
                                : Colors.red),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Transform.scale(
                        scale: 25 / Checkbox.width,
                        child: Checkbox(
                          value: isConditionsAccepted,
                          onChanged: (v) {
                            changeCheckboxValue(v ?? false);
                          },
                          splashRadius: 0,
                          fillColor:
                              MaterialStateProperty.all(AppColors.primary),
                          side: const BorderSide(
                              width: 0, color: Colors.transparent),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Я согласен с ",
                            style: AppTypography.font12w400),
                        TextSpan(
                            text: "Пользовательским Соглашением",
                            style: AppTypography.font12w400.copyWith(
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                await launchUrl(Uri.parse(
                                    'https://docs.google.com/document/d/15zGuCD50uoIJdmAC9_T8tpzzG9NDN26wRNye2Spy160/edit?usp=share_link'));
                              }),
                        TextSpan(
                            text: " и ",
                            style: AppTypography.font12w400.copyWith(
                                decoration: TextDecoration.underline)),
                        TextSpan(
                            text: "Политикой Конфиденциальности",
                            style: AppTypography.font12w400.copyWith(
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                await launchUrl(Uri.parse(
                                    'https://docs.google.com/document/d/1c6zaEfcPYEUsjOpBVnVyzt2Gb3ryIZVBX3O0id4JKik/edit?usp=share_link'));
                              }),
                      ])),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                CustomButton(
                    content: Text(
                      "Войти / Регистрация".toUpperCase(),
                      style: AppTypography.font16w600
                          .copyWith(color: Colors.white),
                    ),
                    onTap: () {
                      final permission = checkFieldsState();

                      if (permission) {
                        context.read<AuthCubit>().auth(
                            email: emailController.text.trim(),
                            password: codeController.text.trim());
                      }
                    },
                    width: double.infinity),
                SizedBox(
                  height: size.height * 0.2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
