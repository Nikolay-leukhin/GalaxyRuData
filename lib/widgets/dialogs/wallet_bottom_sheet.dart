import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/feature/wallet/data/wallet_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/dialogs/show_snack_bar.dart';
import 'package:galaxy_rudata/widgets/snack_bars/success_snack_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

class WalletAddressBottomSheet extends StatelessWidget {
  const WalletAddressBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    const separator16 = SizedBox(height: 16);

    final size = MediaQuery.sizeOf(context);

    final musicRepository = RepositoryProvider.of<MusicRepository>(context);

    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 2),
      decoration: const BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70,
                  height: 2,
                  color: AppColors.lightBlue,
                ),
                separator16,
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: QrImageView(
                    data: context
                        .read<WalletRepository>()
                        .wallet
                        .getAddressForCoin(TWCoinType.TWCoinTypePolygon),
                    version: QrVersions.auto,
                    size: 180,
                    gapless: false,
                  ),
                ),
                separator16,
                Text(
                  'Адрес вашего кошелька в сети Polygon:',
                  style: AppTypography.font14w400
                      .copyWith(color: AppColors.sadGrey),
                  textAlign: TextAlign.center,
                ),
                separator16,
                Text(
                  context
                      .read<WalletRepository>()
                      .wallet
                      .getAddressForCoin(TWCoinType.TWCoinTypePolygon),
                  style: AppTypography.font16w600
                      .copyWith(color: AppColors.blueAccent),
                  textAlign: TextAlign.center,
                ),
                separator16,
                CustomButton(
                    gradient: AppGradients.lightBlue,
                    content: Text(
                      "Копировать адрес".toUpperCase(),
                      style: AppTypography.font16w600
                          .copyWith(color: Colors.white),
                    ),
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text: context
                              .read<WalletRepository>()
                              .wallet
                              .getAddressForCoin(
                                  TWCoinType.TWCoinTypePolygon)));
                      Navigator.pop(context);

                      CustomScaffoldMessenger.show(AppSnackBar.successCopyWallet, context);
                    },
                    width: size.width - 56,
                  audioPlayer: musicRepository.bigButton,),
                separator16
              ],
            ),
          ),
        ),
      ),
    );
  }
}
