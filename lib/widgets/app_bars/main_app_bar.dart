import 'package:flutter/material.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/actions_container.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/rf_container.dart';

class MainAppBar extends PreferredSize {
  MainAppBar(BuildContext context, {super.key, bool isAction = true})
      : super(
          preferredSize: Size(MediaQuery.sizeOf(context).width, 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isAction ? const ActionsContainer() : Container(),
                const RfContainer()
              ],
            ),
          ),
        );
}
