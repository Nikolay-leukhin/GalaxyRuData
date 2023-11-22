import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
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
    final repository = RepositoryProvider.of<LandsRepository>(context);
    final size = MediaQuery.sizeOf(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
                image: AssetImage("assets/images/galaxy.jpg"))),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: MainAppBar.logoutWallet(context),
            body: Stack(
              children: [
                const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        "Нажмите на планету,\nчтобы выбрать район",
                        textAlign: TextAlign.center,

                        style:
                            AppTypography.font18w400.copyWith(color: Colors.white),
                      ),
                    )),
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
                                    height: size.height * 0.53,
                                    padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 24)
                                        .copyWith(bottom: 0),
                                    color: Colors.transparent,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(
                                            repository
                                                .availableClustersNames.length,
                                            (index) => ClusterWidget(
                                                  name: clusters[repository
                                                                  .availableClustersNames[
                                                              index]]
                                                          ?.name ??
                                                      "КЛАСТЕР ДИМЫ СУХОВА",
                                                  type: repository
                                                          .availableClustersNames[
                                                      index],
                                                )),
                                      ),
                                    )),
                              ),
                          width: 100, height: 100,)),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClusterWidget extends StatelessWidget {
  final String name;
  final String type;

  const ClusterWidget({super.key, required this.name, required this.type});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.landsChoose,
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
