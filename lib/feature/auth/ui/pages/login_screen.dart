import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/feature/auth/bloc/auth/auth_cubit.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/utils/validators.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/popup/custom_popup.dart';
import 'package:galaxy_rudata/widgets/text_fields/base_text_form_field.dart';

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

  var isConditionsAccepted = false;

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
      currentRemainingTime -= 1;

      setState(() {});
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void sendAuthCode() {
    errorEmailField = Validator.emailValidator(emailController.text) is String;
    setState(() {});

    if (!errorEmailField) {
      currentRemainingTime = 60;
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
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) => CustomPopup(
                    label: "Некорректный код, пожалуйста, попробуйте еще раз",
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ));
        } else if (state is AuthSuccessState) {
          Navigator.pop(context);

          Navigator.pushNamed(context, RouteNames.authPinCreate);
        } else if (state is AuthLoadingState) {
          showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              });
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
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
              resizeToAvoidBottomInset: false,
              appBar: MainAppBar(
                context,
                isAction: false,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                              keyboardType: TextInputType.emailAddress,
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
                                      content: Text("${currentRemainingTime} СЕКУНД".toUpperCase(),
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
                            color: AppColors.blue,
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
                                  MaterialStateProperty.all(AppColors.blue),
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
                                text: "Правилами Использования",
                                style: AppTypography.font12w400.copyWith(
                                    decoration: TextDecoration.underline)),
                            TextSpan(
                                text: "и ",
                                style: AppTypography.font12w400.copyWith(
                                    decoration: TextDecoration.underline)),
                            TextSpan(
                                text: "Политикой Конфиденциальности ",
                                style: AppTypography.font12w400.copyWith(
                                    decoration: TextDecoration.underline)),
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
                            context.read<AuthRepository>().auth(
                                emailController.text, codeController.text);
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
        ),
      ),
    );
  }
}
