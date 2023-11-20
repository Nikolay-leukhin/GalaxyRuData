import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/feature/lands/bloc/lands_free/lands_free_cubit.dart';
import 'package:galaxy_rudata/feature/lands/bloc/user_lands/lands_user_cubit.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/floating_action_button.dart';
import 'package:galaxy_rudata/widgets/cards/nft_card.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';

class UserLandsScreen extends StatefulWidget {
  const UserLandsScreen({super.key});

  @override
  State<UserLandsScreen> createState() => _UserLandsScreenState();
}

class _UserLandsScreenState extends State<UserLandsScreen> {
  @override
  void initState() {
    context.read<LandsRepository>().loadUserLands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        appBar: MainAppBar.back(context),
        floatingActionButton: const DoubleFloatingButton(),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
            child: BlocBuilder<LandsUserCubit, LandsUserState>(
              builder: (context, state) {
                if (state is LandsUserLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is LandsUserSuccess) {
                  final landsList =
                      context.read<LandsRepository>().userLandsList;

                  if (landsList.isEmpty) {
                    return Center(
                      child: Text(
                        "В вашем кошельке пока нет NFT.",
                        style: AppTypography.font24w700
                            .copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),  
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: List.generate(landsList.length,
                            (index) => NFTCard(land: landsList[index])),
                      ),
                    );
                  }
                }
                return Container();
              },
            )));
  }
}
