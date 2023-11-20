import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/models/land.dart';
import 'package:galaxy_rudata/routes/route_names.dart';
import 'package:galaxy_rudata/services/api/api_service.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/buttons/floating_action_button.dart';
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

    final land = ((ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map)['land'] as LandModel;

    return MainScaffold(
        appBar: MainAppBar.backWallet(context),
        body: Container(
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
                child: Stack(children: [
                  SvgPicture.asset(
                    'assets/icons/bottom_bcg.svg',
                    width: sizeOf.width,
                    height: sizeOf.width,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    width: sizeOf.width,
                    height: sizeOf.height,
                    padding: const EdgeInsets.symmetric(horizontal: 43),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Бизнес кластер'.toUpperCase(),
                          style: AppTypography.font20w600,
                        ),
                        Text(
                          'Бизнес кластер - это райский уголок для предпринимателей и амбициозных стартаперов, расположенный в самом сердце делового района мегаполиса. Этот район является идеальным местом для тех, кто хочет максимально эффективно использовать свое время и ресурсы, находясь в окружении единомышленников, готовых делиться опытом и знаниями.',
                          style: AppTypography.font12w400,
                          textAlign: TextAlign.center,
                        ),
                        CustomButton(
                            content: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: FittedBox(child: Text('Забронировать жилье'.toUpperCase(), style: AppTypography.font16w600,)),
                            ),
                            onTap: () {
                              context.read<LandsRepository>().connectLandToCurrentCode(land.id);
                              Navigator.popUntil(context, ModalRoute.withName(RouteNames.root));
                            },
                            width: double.infinity)
                      ],
                    ),
                  )
                ]),
              ),
            ],
          ),
        ));
  }
}
