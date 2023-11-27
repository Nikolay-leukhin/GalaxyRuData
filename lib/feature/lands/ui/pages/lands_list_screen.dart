import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/feature/lands/bloc/lands_free/lands_free_cubit.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/floating_action_button.dart';
import 'package:galaxy_rudata/widgets/cards/nft_card.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';

class LandsListScreen extends StatefulWidget {
  const LandsListScreen({super.key});

  @override
  State<LandsListScreen> createState() => _LandsListScreenState();
}

class _LandsListScreenState extends State<LandsListScreen> {
  @override
  void initState() {
    context.read<LandsRepository>().loadFreeLands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        appBar: MainAppBar.logoutWallet(context),
        floatingActionButton: const DoubleFloatingButton(),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
            child: BlocBuilder<LandsFreeCubit, LandsFreeState>(
              builder: (context, state) {
                if (state is LandsFreeLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is LandsFreeSuccess) {
                  final landsList =
                      context.read<LandsRepository>().freeLandsList;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Выберите участок',
                          style: AppTypography.font16w700,
                        )
                      ]..addAll(List.generate(
                          landsList.length,
                          (index) => NFTCard(
                                land: landsList[index],
                                onTap: () {
                                  // context
                                  //     .read<LandsRepository>()
                                  //     .connectLandToCurrentCode(
                                  //         landsList[index].id);
                                  Navigator.pushNamed(
                                      context, RouteNames.cluster, arguments: {'land': landsList[index]});
                                },
                              ))),
                    ),
                  );
                }
                return Container();
              },
            )));
  }
}
