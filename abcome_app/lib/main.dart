import 'package:abcome_app/screens/historic_page.dart';
import 'package:abcome_app/screens/home_page.dart';
import 'package:abcome_app/screens/loading_page.dart';
import 'package:abcome_app/screens/members/member_details_page.dart';
import 'package:abcome_app/screens/members/members_page.dart';
import 'package:abcome_app/screens/poll/poll_page.dart';
import 'package:abcome_app/screens/poll/vote_page.dart';
import 'package:abcome_app/screens/results_page.dart';
import 'package:abcome_app/screens/settings_page.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/lifecycle_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final double screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  if (screenWidth < 600) {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  } else {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

    // Para evitar o delay ao carregar a imagem de fundo
    if (screenWidth > 600) {
      precacheImage(const AssetImage(kBackgroundTablet), context);
    } else {
      precacheImage(const AssetImage(kBackgroundMobile), context);
    }

    return LifeCycleManager(
      child: GlobalLoaderOverlay(
        child: MaterialApp(
          title: 'A.B.Come',
          theme: ThemeData(
            primaryColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: LoadingPage.id,
          routes: {
            LoadingPage.id: (context) => const LoadingPage(),
            HomePage.id: (context) => const HomePage(),
            PollPage.id: (context) => const PollPage(),
            VotePage.id: (context) => const VotePage(),
            MembersPage.id: (context) => const MembersPage(),
            MemberDetailsPage.id: (context) => const MemberDetailsPage(),
            ResultsPage.id: (context) => const ResultsPage(),
            HistoricPage.id: (context) => const HistoricPage(),
            SettingsPage.id: (context) => const SettingsPage(),
          },
        ),
      ),
    );
  }
}
