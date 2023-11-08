import 'package:flutter/material.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/actions_container.dart';
import 'package:galaxy_rudata/widgets/app_bar_items/rf_container.dart';

class MainAppBar extends AppBar {
  MainAppBar()
      : super(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ActionsContainer(), RfContainer()],
          ),
        );
}
