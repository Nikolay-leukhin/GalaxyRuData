import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/routes/routes.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/dialogs/show_bottom_sheet.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';
import 'package:permission_handler/permission_handler.dart';

// const String _congratulationsMessage =
//     'Чтобы получить NFT-сертификат, пройдите квесты на космической базе Большого Росреестра в метавселенной Spatial. Вы можете сделать это как с телефона, так и на компьютере.';

const String _inDevelopingMessage =
    'Вы сделали первый шаг в оформлении жилья на планете НСПД во Вселенной Большого Росреестра! Скоро вы сможете пройти квесты в метавселенной Spatial и получить NFT-cертификат. Мы сообщим вам сразу, как это станет доступно.';

const String _doNotDisableNotifications =
    'Пожалуйста, не отключайте уведомления!';

const String _pleaseGrantTheAccess =
    'Пожалуйста, подключите уведомления, чтобы не пропустить самое интересное!';

class QuestsScreen extends StatefulWidget {
  const QuestsScreen({super.key});

  @override
  State<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  bool notificationsPermissionIsGranted = false;
  bool fieldPermissionStatusInitialized = false;

  @override
  void initState() {
    getPermissionState();
    super.initState();
  }

  void getPermissionState() async {
    late PermissionStatus permissionStatus;

    permissionStatus = await Permission.notification.status;

    notificationsPermissionIsGranted = permissionStatus.isGranted;
    print(notificationsPermissionIsGranted);

    fieldPermissionStatusInitialized = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final separate = Container(
      height: size.height * 0.05,
      constraints: const BoxConstraints(maxHeight: 60),
    );

    final musicRepository = RepositoryProvider.of<AudioRepository>(context);

    return MainScaffold(
        canPop: false,
        appBar: MainAppBar.logoutWallet(context),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: size.width * 0.6,
                constraints: const BoxConstraints(maxWidth: 350),
                child: Text(
                  'Поздравляем!',
                  textAlign: TextAlign.center,
                  style: size.width > 300
                      ? AppTypography.font24w700
                      : AppTypography.font16w700,
                ),
              ),
              separate,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _inDevelopingMessage,
                      style: size.width > 300
                          ? AppTypography.font16w400
                          : AppTypography.font14w400,
                      textAlign: TextAlign.center,
                    ),
                    separate,
                    CustomButton(
                        content: Text(
                          'Квесты на телефоне'.toUpperCase(),
                          style: AppTypography.font16w400,
                        ),
                        audioPlayer: musicRepository.bigButton,
                        onTap: () {
                          Navigator.of(context).pushNamed(RouteNames.game);
                        },
                        width: double.infinity),
                    const SizedBox(
                      height: 16,
                    ),
                    if (fieldPermissionStatusInitialized) ...[
                      notificationsPermissionIsGranted
                          ? Container()
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _pleaseGrantTheAccess,
                                  style: size.width > 300
                                      ? AppTypography.font16w400
                                      : AppTypography.font14w400,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                CustomButton(
                                  content: Text(
                                    'УВЕДОМЛЕНИЯ',
                                    style: AppTypography.font16w400,
                                  ),
                                  onTap: () async {
                                    await Permission.notification.request();

                                    getPermissionState();
                                  },
                                  width: double.infinity,
                                  audioPlayer: musicRepository.bigButton,
                                )
                              ],
                            )
                    ] else ...[
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(),
                      )
                    ]
                  ],
                ),
              ),

              // separate,
              // CustomButton(
              //     content: Text(
              //       'Квесты на компьютере'.toUpperCase(),
              //       style: AppTypography.font16w400,
              //     ),
              //     onTap: () {
              //       ShowBottomSheet.show(
              //         context,
              //         const BottomSheetLinks(),
              //       );
              //     },
              //     width: double.infinity),

              // separate,
              // CustomButton(
              //     content: Text(
              //       'Я уже прошел квесты!'.toUpperCase(),
              //       style: AppTypography.font16w400,
              //     ),
              //     onTap: () async {
              //       RepositoryProvider.of<LandsRepository>(context)
              //           .getApprove()
              //           .then((value) =>
              //               Navigator.pushNamed(context, RouteNames.safe));
              //     },
              //     width: double.infinity),
            ],
          ),
        ));
  }
}
