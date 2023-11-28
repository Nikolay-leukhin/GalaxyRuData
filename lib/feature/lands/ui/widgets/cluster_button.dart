import 'package:flutter/material.dart';
import 'package:galaxy_rudata/routes/route_names.dart';

import '../../../../utils/utils.dart';

class ClusterButton extends StatelessWidget {
  final String name;
  final String type;

  const ClusterButton({super.key, required this.name, required this.type});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.cluster,
            arguments: {'cluster': type});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: AppGradients.space,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width - 105,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.font16w600.copyWith(color: Colors.white),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 24,
              ),
            )
          ],
        ),
      ),
    );
  }
}