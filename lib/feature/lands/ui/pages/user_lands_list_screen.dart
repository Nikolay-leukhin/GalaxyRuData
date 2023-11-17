import 'package:flutter/material.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/floating_action_button.dart';
import 'package:galaxy_rudata/widgets/cards/nft_card.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';

class UserLandsListScreen extends StatefulWidget {
  const UserLandsListScreen({super.key});

  @override
  State<UserLandsListScreen> createState() => _NFTStorageScreenState();
}

class _NFTStorageScreenState extends State<UserLandsListScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return MainScaffold(
        appBar: MainAppBar.back(context),
        floatingActionButton: const DoubleFloatingButton(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, i) => NFTCard(
                    size: size.width - 48 < 327 ? size.width - 48 : 327,
                    image: 'assets/images/s.png',
                    title: 'Семейный кластер',
                    nftType: NFTypes.nftCertificate,
                    id: '03-00001',
                  )),
        ));
  }
}
