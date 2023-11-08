import 'package:flutter/material.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        border: Border.all(width: 1, color: AppColors.silver),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Transform.scale(
                        scale: 25 / Checkbox.width,
                        child: Checkbox(
                          value: true,
                          onChanged: (v) {},
                          splashRadius: 0,
                          fillColor: MaterialStateProperty.all(AppColors.blue),
                          side: const BorderSide(
                              width: 0, color: AppColors.silver),
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
                      Navigator.pushNamed(context, RouteNames.nftCertificate);
                    },
                    width: double.infinity)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
