import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/utils/clusters.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ArPlanetViewScreen extends StatefulWidget {
  const ArPlanetViewScreen({super.key});

  @override
  ArPlanetViewScreenState createState() => ArPlanetViewScreenState();
}

class ArPlanetViewScreenState extends State<ArPlanetViewScreen> {

  @override
  void initState() {
    context.read<LandsRepository>().loadFreeLands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/galaxy.jpg"))),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: MainAppBar.logoutWallet(context),
          body: Stack(
            children: [
              const Center(
                      child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,),
                    ),
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  alignment: Alignment.center,
                  child: ModelViewer(
                    loading: Loading.eager,
                    touchAction: TouchAction.none,
                    onWebViewCreated: (controller) {
            
                    },

                    disableTap: true,
                    backgroundColor: Colors.transparent,
                    src: 'assets/planet.glb',
                    alt: 'A 3D model of an planet',
                    ar: false,
                    autoRotate: true,
                    iosSrc: 'assets/planet.glb',
                    disableZoom: true,
                    disablePan: true,
                  ),
                ),
              ),
              Center(
                child: Opacity(
                    opacity: 0,
                    child: CustomButton(
                        content: Text('shit'),
                        onTap: () => showModalBottomSheet(
                              useSafeArea: true,
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) => Container(
                                  padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 24)
                                      .copyWith(bottom: 0),
                                  color: Colors.transparent,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                          context
                                              .read<LandsRepository>()
                                              .availableClustersNames
                                              .length,
                                          (index) => ClusterWidget(
                                              name: clusters[context
                                                          .read<
                                                              LandsRepository>()
                                                          .availableClustersNames[index]]
                                                      ?.name ??
                                                  "КЛАСТЕР ДИМЫ СУХОВА")),
                                    ),
                                  )),
                            ),
                        width: 100)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class ClusterWidget extends StatelessWidget {
  final String name;

  const ClusterWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.darkBlue3,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: AppTypography.font16w600.copyWith(color: Colors.white),
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
    );
  }
}
