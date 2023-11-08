import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/feature/auth/ui/widgets/pin_code_indicator.dart';
import 'package:galaxy_rudata/feature/auth/ui/widgets/pin_num_tab.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/rf_container.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  List<int> pinData = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final pinKeyboard = [1, 2, 3, 4, 5, 6, 7, 8, 9, "", 0, "del"];

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
                image: AssetImage("assets/images/auth_background.png"))),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: const [RfContainer()],
            ),
            body: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
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
                  Container(height: size.height * 0.078, constraints: const BoxConstraints(maxHeight: 70),),

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
                  Container(height: size.height * 0.089, constraints: const BoxConstraints(maxHeight: 90),),
                  Container(
                    width: size.width * 0.73,
                    constraints: BoxConstraints(maxWidth: 500),
                    child: Wrap(
                      spacing: 32,
                      runSpacing: 16,
                      alignment: WrapAlignment.spaceBetween,
                      children: List.generate(pinKeyboard.length, (i) {
                        final index = pinKeyboard[i];
                        if (pinKeyboard[i] == "") {
                          return SizedBox(
                            width: 70,
                          );
                        } else if (pinKeyboard[i] == "del") {
                          return PinNumTab(
                            onTap: () {
                              if (pinData.isNotEmpty) {
                                pinData.removeLast();
                              }
                              setState(() {});
                            },
                            content: SvgPicture.asset('assets/icons/delete.svg', width: 24, color: Colors.white,),
                          );
                        }

                        return PinNumTab(
                          content: Text(
                            index.toString(),
                            style: AppTypography.font24w700
                                .copyWith(color: Colors.white),
                          ),
                          onTap: () {


                            if (pinData.length != 4){
                              pinData.add(pinKeyboard[i] as int);
                            }
                            setState(() {});
                          },
                        );
                      }),
                    ),
                  ),

                  Container(height: size.height * 0.17, constraints: const BoxConstraints(maxHeight: 150),),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
