import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/feature/lands/bloc/connect_land/connect_land_cubit.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/clusters.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/popup/custom_popup.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';

class ClusterScreen extends StatefulWidget {
  const ClusterScreen({super.key});

  @override
  State<ClusterScreen> createState() => _ClusterScreenState();
}

class _ClusterScreenState extends State<ClusterScreen> {
  @override
  void initState() {
    // context.read<LandsRepository>().loadFreeLands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    print(sizeOf.width);

    final clusterType = ((ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map)['cluster'] as String;

    return BlocListener<ConnectLandCubit, ConnectLandState>(
      listener: (context, state) {
        if (state is ConnectLandFailure) {
          Dialogs.hide(context);
          Dialogs.showModal(
              context,
              CustomPopup(
                label: "Что-то пошло не так. Попробуйте позже",
                onTap: () {
                  Dialogs.hide(context);
                },
              ));
        } else if (state is ConnectLandSuccess) {
          Dialogs.hide(context);

          Future.delayed(const Duration(milliseconds: 500)).then((value) {
            Navigator.popUntil(context, ModalRoute.withName(RouteNames.root));
          });
        } else if (state is ConnectLandLoading) {
          Dialogs.showModal(
              context,
              const Center(
                child: CircularProgressIndicator.adaptive(),
              ));
        }
      },
      child: MainScaffold(
          canPop: false,
          appBar: MainAppBar.backWallet(context),
          body: SizedBox(
            width: sizeOf.width,
            height: sizeOf.height,
            child: Stack(
              children: [
                Positioned(
                  bottom: sizeOf.height * 0.43 - 55,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: sizeOf.width,
                      height: sizeOf.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(clusters[clusterType]!.asset),
                        fit: BoxFit.fitWidth,
                      )),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: sizeOf.width,
                    height: sizeOf.height * 0.43,
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      Positioned(
                        bottom: 0,
                        child: SizedBox(
                          width: sizeOf.width,
                          height: sizeOf.height * 0.43,
                          child: SvgPicture.asset(
                            'assets/icons/bottom_bcg.svg',
                            fit: BoxFit.fill,
                          ),
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
                              const Spacer(
                                flex: 2,
                              ),
                              Text(
                                clusters[clusterType]!.name.toUpperCase(),
                                style: AppTypography.font20w600,
                                textAlign: TextAlign.center,
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Text(
                                clusters[clusterType]!.description,
                                style: AppTypography.font12w400,
                                textAlign: TextAlign.center,
                              ),
                              const Spacer(
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
                                  onTap: () async {
                                    context
                                        .read<ConnectLandCubit>()
                                        .connectRandomFromClusterLandToCurrentCode(
                                            clusterType);
                                  },
                                  width: double.infinity),
                              const Spacer(
                                flex: 2,
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
