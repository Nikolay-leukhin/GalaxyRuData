import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/clusters.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';

class LandChooseScreen extends StatefulWidget {
  const LandChooseScreen({super.key});

  @override
  State<LandChooseScreen> createState() => _LandChooseScreenState();
}

class _LandChooseScreenState extends State<LandChooseScreen> {
  @override
  void initState() {
    context.read<LandsRepository>().loadFreeLands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    final clusterType = ((ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map)['cluster'] as String;

    return WillPopScope(
      onWillPop: () async => false,
      child: MainScaffold(
          appBar: MainAppBar.backWallet(context),
          body: SizedBox(
            width: sizeOf.width,
            height: sizeOf.height,
            child: Stack(
              children: [
                Container(
                  width: sizeOf.width * 4,
                  height: sizeOf.width * 1.1,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/klaster.png'),
                    fit: BoxFit.fitWidth,
                  )),
                ),
                Positioned(
                  bottom: 0,
                  top: sizeOf.height * 0.4,
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    Positioned(
                      bottom: 0,
                      top: 0,
                      child: SvgPicture.asset(
                        'assets/icons/bottom_bcg.svg',
                        width: sizeOf.width,
                        height: sizeOf.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: sizeOf.width,
                        height: sizeOf.height,
                        padding: const EdgeInsets.symmetric(horizontal: 43),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Spacer(
                              flex: 2,
                            ),
                            Text(
                              clusters[clusterType]!.name.toUpperCase(),
                              style: AppTypography.font20w600,
                              textAlign: TextAlign.center,
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              clusters[clusterType]!.description,
                              style: AppTypography.font12w400,
                              textAlign: TextAlign.center,
                            ),
                            Spacer(
                              flex: 2,
                            ),
                            CustomButton(
                                content: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: FittedBox(
                                      child: Text(
                                    'Забронировать жилье'.toUpperCase(),
                                    style: AppTypography.font16w600,
                                  )),
                                ),
                                onTap: () {
                                  context
                                      .read<LandsRepository>()
                                      .connectRandomFromClusterLandToCurrentCode(
                                          clusterType)
                                      .then((value) =>
                                          RepositoryProvider.of<AuthRepository>(
                                                  context)
                                              .appState
                                              .add(AppStateEnum.auth))
                                      .then((value) => null);
                                  Future.delayed(
                                          const Duration(milliseconds: 500))
                                      .then((value) => Navigator.popUntil(
                                          context,
                                          ModalRoute.withName(
                                              RouteNames.root)));
                                },
                                width: double.infinity),
                            Spacer(
                              flex: 2,
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ],
            ),
          )),
    );
  }
}
//
// class ClusterType {
//   final String title;
//   final String description;
//   final String asset;
// }
