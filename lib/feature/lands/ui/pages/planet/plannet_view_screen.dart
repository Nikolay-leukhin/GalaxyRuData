import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/utils/clusters.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../widgets/cluster_button.dart';

class ArPlanetViewScreen extends StatefulWidget {
  const ArPlanetViewScreen({super.key});

  @override
  ArPlanetViewScreenState createState() => ArPlanetViewScreenState();
}

class ArPlanetViewScreenState extends State<ArPlanetViewScreen> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final planet = ModelViewer(
      interactionPrompt: InteractionPrompt.none,
      interactionPromptThreshold: 0,
      loading: Loading.eager,
      touchAction: TouchAction.none,
      onWebViewCreated: (controller) {},
      disableTap: true,
      backgroundColor: Colors.transparent,
      src: 'assets/planet.glb',
      alt: 'A 3D model of a planet',
      ar: false,
      autoRotate: true,
      iosSrc: 'assets/Planet.usdc',
      disableZoom: true,
      disablePan: true,
    );

    final musicRepository = RepositoryProvider.of<AudioRepository>(context);

    return PopScope(
      canPop: false,
      child: Container(
        padding: const EdgeInsets.only(top: 15),
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
                        style: AppTypography.font18w400
                            .copyWith(color: Colors.white),
                      ),
                    )),
                Center(
                  child: Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      alignment: Alignment.center,
                      child: planet),
                ),
                Center(
                  child: Opacity(
                    opacity: 0,
                    child: CustomButton(
                      content: const Text('shit'),
                      width: size.width,
                      height: size.width,
                      onTap: () async {
                        controller = ScrollController();

                        await showClusters(context);

                        controller.dispose();
                      },
                      audioPlayer: musicRepository.bigButton,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showClusters(BuildContext context) async {
    final musicRepository = RepositoryProvider.of<AudioRepository>(context);

    final size = MediaQuery.sizeOf(context);
    final List clustersTypes = clusters.keys.toList();
    final clustersList = List.generate(
        clustersTypes.length,
        (index) => ClusterButton(
              name: clusters[clustersTypes[index]]!.name !=
                      'АДМИНИСТРАТИВНЫЙ КЛАСТЕР'
                  ? clusters[clustersTypes[index]]!.name
                  : 'АДМИН. КЛАСТЕР',
              type: clustersTypes[index],
            ));

    bottomButton(bool isActive) => isActive
        ? Positioned(
            bottom: 0,
            child: Container(
                width: size.width,
                height: 90,
                padding: const EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38.withOpacity(0.5),
                        spreadRadius: 10,
                        offset: const Offset(0, 3),
                        blurRadius: 100),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_downward_sharp,
                    size: 50,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    controller.animateTo(
                      controller.position.pixels + 78,
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                )))
        : const SizedBox();

    musicRepository.play(musicRepository.popUp);

    bool isActiveBottomButton = true;

    await showModalBottomSheet(
        useSafeArea: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: size.height * 0.53,
            color: Colors.transparent,
            child: StatefulBuilder(builder: (context, setState) {
              return Stack(children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 24)
                          .copyWith(bottom: 0),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                        mainAxisSize: MainAxisSize.min, children: clustersList),
                  ),
                ),
                StatefulBuilder(builder: (context, setState) {
                  controller.addListener(() {
                    double maxScroll = controller.position.maxScrollExtent;
                    double currentScroll = controller.position.pixels;

                    if (currentScroll >= maxScroll * 0.8) {
                      setState(() {
                        isActiveBottomButton = false;
                      });
                    } else if (currentScroll <= maxScroll * 0.3) {
                      setState(() {
                        isActiveBottomButton = true;
                      });
                    }
                  });

                  print(isActiveBottomButton);
                  return bottomButton(isActiveBottomButton);
                })
              ]);
            }),
          );
        }).then((value) => musicRepository.play(musicRepository.popDown));
  }
}
