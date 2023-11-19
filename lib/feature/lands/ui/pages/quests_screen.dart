import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/feature/lands/ui/widgets/bottom_sheet_links.dart';
import 'package:galaxy_rudata/feature/lands/ui/widgets/sperial_bottom_sheet.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/dialogs/show_bottom_sheet.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';

const String _congratulationsMessage =
    'Чтобы получить NFT-сертификат, пройдите квесты на космической базе Большого Росреестра в метавселенной Spatial. Вы можете сделать это как с телефона, так и на компьютере.';

class QuestsScreen extends StatefulWidget {
  const QuestsScreen({super.key});

  @override
  State<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final separate = Container(
      height: size.height * 0.05,
      constraints: const BoxConstraints(maxHeight: 60),
    );
    print('-' * 40);
    print(context.read<LandsRepository>().code);
    return MainScaffold(
        appBar: MainAppBar.logoutWallet(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: size.width * 0.6,
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: Text(
                    'Поздравляем, вы забронировали жилье!',
                    textAlign: TextAlign.center,
                    style: size.width > 300
                        ? AppTypography.font24w700
                        : AppTypography.font16w700,
                  ),
                ),
                separate,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    _congratulationsMessage,
                    style: size.width > 300
                        ? AppTypography.font16w400
                        : AppTypography.font14w400,
                    textAlign: TextAlign.center,
                  ),
                ),
                separate,
                CustomButton(
                    content: Text(
                      'Квесты на компьютере'.toUpperCase(),
                      style: AppTypography.font16w400,
                    ),
                    onTap: () {
                      ShowBottomSheet.show(
                        context,
                        const BottomSheetLinks(),
                      );
                    },
                    width: double.infinity),
                separate,
                CustomButton(
                    content: Text(
                      'Квесты на телефоне'.toUpperCase(),
                      style: AppTypography.font16w400,
                    ),
                    onTap: () {
                      ShowBottomSheet.show(
                        context,
                        const BottomSheetSpatial(),
                      );
                    },
                    width: double.infinity),
                separate,
                CustomButton(
                    content: Text(
                      'Я уже прошел квесты!'.toUpperCase(),
                      style: AppTypography.font16w400,
                    ),
                    onTap: () async {
                      RepositoryProvider.of<LandsRepository>(context)
                          .getApprove()
                          .then((value) =>
                              Navigator.pushNamed(context, RouteNames.safe));
                    },
                    width: double.infinity),
              ],
            ),
          ),
        ));
  }
}
