import 'dart:ui';

import 'package:flutter/material.dart';

class ShowBottomSheet{
  static Future<void> show(BuildContext context, Widget widget) async{
    showModalBottomSheet(
        elevation: 0,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: widget,
          );
        });
  }
}