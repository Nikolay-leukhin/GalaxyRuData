import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key, required this.actions});

  final List<AppBarButton> actions;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (var i = 0; i < actions.length; i ++) {
      children.add(actions[i]);
      if (i != actions.length - 1 && actions.length != 1) {
        children.add(
          const SizedBox(width: 30,));
      }
    }

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
            children: children
        ),
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  const AppBarButton({super.key, required this.onTap, required this.iconName});

  final VoidCallback onTap;

  /// Указывать не полным путем, а только то что после ...icons/
  /// Например не 'assets/icons/wallet.svg' а wallet.svg
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: () {},
        child: SvgPicture.asset(
          'assets/icons/$iconName',
          width: 32,
          height: 32,
        ),
      );
  }
}

