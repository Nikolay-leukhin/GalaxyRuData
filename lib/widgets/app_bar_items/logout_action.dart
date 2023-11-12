import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class LogoutAction extends StatelessWidget {
  const LogoutAction({super.key});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(40);
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.only(
              topRight: radius, topLeft: radius, bottomRight: radius)),
      width: 145,
      height: 60,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.authPinEnter);
              },
              child: SvgPicture.asset(
                'assets/icons/back.svg',
                width: 32,
                height: 32,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/icons/wallet.svg',
                width: 32,
                height: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
