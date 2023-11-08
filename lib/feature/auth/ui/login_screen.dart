import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/text_fields/base_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/auth_background.png"))),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseTextFormField(
                  withError: false,
                  controller: controller,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "E-mail адрес",
                ),
                const SizedBox(
                  height: 32,
                ),
                BaseTextFormField(
                  controller: controller,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Код",
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (v) {}, ),
                    Flexible(
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Я согласен с ",
                            style: AppTypography.font12w400),
                        TextSpan(
                            text: "Правилами Использования",
                            style: AppTypography.font12w400
                                .copyWith(decoration: TextDecoration.underline)),
                        TextSpan(
                            text: "и ",
                            style: AppTypography.font12w400
                                .copyWith(decoration: TextDecoration.underline)),
                        TextSpan(
                            text: "Политикой Конфиденциальности ",
                            style: AppTypography.font12w400
                                .copyWith(decoration: TextDecoration.underline)),
                      ])),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
