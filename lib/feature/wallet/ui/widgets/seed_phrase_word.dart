import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class SeedPhraseWordWidget extends StatelessWidget {
  final int index;
  final String word;

  const SeedPhraseWordWidget(
      {super.key, required this.index, required this.word});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: 20,
            child: Text(
              "$index. ",
              style: AppTypography.font16w400.copyWith(color: Colors.white),
            ),
          ),
          Text(
            word,
            style: AppTypography.font16w400.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
