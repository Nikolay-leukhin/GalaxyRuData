import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/routes/routes.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/dialogs/show_bottom_sheet.dart';
import 'package:galaxy_rudata/widgets/dialogs/wallet_bottom_sheet.dart';

class DoubleFloatingButton extends StatelessWidget {
  const DoubleFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final musicRepository =RepositoryProvider.of<MusicRepository>(context);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              musicRepository.play(musicRepository.popUp);

              ShowBottomSheet.show(context, const WalletAddressBottomSheet()).then((value) => musicRepository.play(musicRepository.popDown));
            },
            child: Ink(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: AppGradients.oceanBlue,
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset('assets/images/info.png'),
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              Navigator.pushNamed(context, RouteNames.walletSeedPhraseView);
            },
            child: Ink(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: AppGradients.oceanBlue,
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset('assets/images/key.png'),
            ),
          ),
        ),
      ],
    );
  }
}
