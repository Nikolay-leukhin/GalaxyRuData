import 'package:flutter/material.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/rf_container.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/text_fields/base_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  var isConditionsAccepted = false;

  bool errorEmailField = false;
  bool errorCodeField = false;
  bool withErrorCheckBox = false;

  void changeCheckboxValue(bool value) {
    setState(() {
      isConditionsAccepted = value;
    });
  }

  bool checkPermission() {
    if (isConditionsAccepted == false){
      setState(() {
        withErrorCheckBox = true;
      });
      return false;
    }

    return true;
  }

  bool checkEmail() {
    return emailController.text == "";
  }

  bool checkCode() {
    return codeController.text == "";
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/auth_background.png"))),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: const [RfContainer()],
          ),
          backgroundColor: Colors.transparent,
          body: Container(
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
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22).copyWith(right: 120),
                          controller: codeController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Код",
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: CustomButton(
                            content: Text("Отправить".toUpperCase(),
                                style: AppTypography.font16w600
                                    .copyWith(color: Colors.white)),
                            onTap: () {},
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
                        border: Border.all(width: 2, color: !withErrorCheckBox ? AppColors.silver : Colors.red),
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
                          fillColor: MaterialStateProperty.all(AppColors.blue),
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
                      final permission = checkPermission();
                      errorCodeField = checkCode();
                      errorEmailField = checkEmail();
                      setState(() {});
                      if (permission) {
                        Navigator.pushNamed(context, RouteNames.safe);
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
