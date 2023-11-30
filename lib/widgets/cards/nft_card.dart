import 'package:flutter/material.dart';
import 'package:galaxy_rudata/models/land.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class NFTCard extends StatelessWidget {
  const NFTCard({super.key, required this.land, this.onTap});

  final LandModel land;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: size.height * 0.4,
        constraints: const BoxConstraints(maxHeight: 500),
        margin: const EdgeInsets.only(top: 16, bottom: 16),
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/images/s.png"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  SizedBox(
                    width: size.width - 80,
                    child: Text(
                      land.name,
                      style: AppTypography.font16w600,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    width: size.width - 80,
                    child: Text(
                      land.type,
                      style: AppTypography.font12w400,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    width: size.width - 80,
                    child: Text(
                      land.description ?? '',
                      style: AppTypography.font12w400,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NFTypes {
  static const String nftCertificate = 'NFT сертификат';
}
