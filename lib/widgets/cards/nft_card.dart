import 'package:flutter/material.dart';
import 'package:galaxy_rudata/utils/utils.dart';

class NFTCard extends StatelessWidget {
  const NFTCard(
      {super.key,
      required this.size,
      required this.image,
      required this.title,
      required this.nftType,
      required this.id, this.onTap});

  final double size;

  final String image;
  final String title;
  final String nftType;
  final String id;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(image))),
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
                  const SizedBox(width: double.infinity,),
                  SizedBox(
                    width: size - 24,
                    child: Text(
                      title,
                      style: AppTypography.font16w600,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    width: size - 24,
                    child: Text(
                      nftType,
                      style: AppTypography.font12w400,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    width: size - 24,
                    child: Text(
                      'Жилье во владении № $id',
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
