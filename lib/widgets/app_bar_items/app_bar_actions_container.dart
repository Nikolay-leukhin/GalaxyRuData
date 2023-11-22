import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/app_bar_button.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key, required this.actions});

  final List<AppBarButton> actions;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    final maxHeight = min(MediaQuery.sizeOf(context).width / 6, 60).toDouble();

    for (var i = 0; i < actions.length; i++) {
      children.add(actions[i]);
      if (i != actions.length - 1 && actions.length != 1) {
        children.add(SizedBox(
          width: maxHeight / 2,
        ));
      }
    }

    final radius = Radius.circular(maxHeight / 2);
    return Container(
      decoration: BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.only(
              topRight: radius, topLeft: radius, bottomRight: radius)),
      height: maxHeight,
      padding: EdgeInsets.symmetric(
          horizontal: maxHeight / 2.5, vertical: maxHeight / 4.2),
      child: Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}

