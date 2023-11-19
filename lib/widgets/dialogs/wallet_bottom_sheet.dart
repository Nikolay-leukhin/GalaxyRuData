import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/feature/wallet/data/wallet_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

class WalletAddressBottomSheet extends StatelessWidget {
  const WalletAddressBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    const seperator16 = SizedBox(
      height: 16,
    );

    final size = MediaQuery.sizeOf(context);

    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 2),
      decoration: const BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Container(      clipBehavior: Clip.hardEdge,

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
                seperator16,
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
                seperator16,
                Text(
                  'Адрес вашего кошелька в сети Polygon:',
                  style: AppTypography.font14w400
                      .copyWith(color: AppColors.sadGrey),
                  textAlign: TextAlign.center,
                ),
                seperator16,
                Text(
                  context
                      .read<WalletRepository>()
                      .wallet
                      .getAddressForCoin(TWCoinType.TWCoinTypePolygon),
                  style: AppTypography.font16w600
                      .copyWith(color: AppColors.blueAccent),
                  textAlign: TextAlign.center,
                ),
                seperator16,
                CustomButton(
                    gradient: AppGradients.lightBlue,
                    content: Text(
                      "Копировать адрес".toUpperCase(),
                      style: AppTypography.font16w600
                          .copyWith(color: Colors.white),
                    ),
                    onTap: () {},
                    width: size.width - 56),
                seperator16
              ],
            ),
          ),
        ),
      ),
    );
  }
}
