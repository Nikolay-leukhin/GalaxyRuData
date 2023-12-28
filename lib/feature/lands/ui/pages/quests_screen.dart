import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_rudata/audio_repository.dart';
import 'package:galaxy_rudata/routes/routes.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:galaxy_rudata/widgets/app_bars/main_app_bar.dart';
import 'package:galaxy_rudata/widgets/buttons/custom_button.dart';
import 'package:galaxy_rudata/widgets/scaffolds/main_scaffold.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// const String _congratulationsMessage =
//     'Чтобы получить NFT-сертификат, пройдите квесты на космической базе Большого Росреестра в метавселенной Spatial. Вы можете сделать это как с телефона, так и на компьютере.';

const String _inDevelopingMessage =
    'Чтобы получить NFT-сертификат, пройдите квесты на космической базе Большого Росреестра в метавселенной Spatial. Вы можете сделать это как с телефона, так и на компьютере, открыв ссылку в браузере.';

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
    final notificationPermissionStatus = await Permission.notification.status;

    notificationsPermissionIsGranted = notificationPermissionStatus.isGranted;

    fieldPermissionStatusInitialized = true;
    setState(() {});
  }

  Future<void> requestPermission() async {
    if (!notificationsPermissionIsGranted) {
      await Permission.notification.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final separate = Container(
      height: 32,
    );

    final musicRepository = RepositoryProvider.of<AudioRepository>(context);

    return MainScaffold(
        canPop: false,
        appBar: MainAppBar.logoutWallet(context),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          'Квесты на компьютере'.toUpperCase(),
                          style: AppTypography.font16w400,
                        ),
                        onTap: () async {
                          await Share.share(
                              'https://www.spatial.io/s/Vselennaia-Bol-shogo-Rosreestra-658d5cef60c4e4c38b3e243b?share=0');
                        },
                        width: double.infinity,
                        audioPlayer: musicRepository.bigButton,
                      ),
                      separate,
                      CustomButton(
                          content: Text(
                            'Квесты на телефоне'.toUpperCase(),
                            style: AppTypography.font16w400,
                          ),
                          audioPlayer: musicRepository.bigButton,
                          onTap: () {
                            launchUrl(Uri.parse(
                                'https://www.spatial.io/s/Vselennaia-Bol-shogo-Rosreestra-658d5cef60c4e4c38b3e243b?share=0'));
                          },
                          width: double.infinity),
                      separate,
                      CustomButton(
                          content: Text(
                            'Я уже прошел квесты!'.toUpperCase(),
                            style: AppTypography.font16w400,
                          ),
                          audioPlayer: musicRepository.bigButton,
                          onTap: () {
                            Navigator.of(context).pushNamed(RouteNames.safe);
                          },
                          width: double.infinity),
                    ],
                  ),
                ),
                SizedBox(height: 100,)

              ],
            ),
          ),
        ));
  }
}
