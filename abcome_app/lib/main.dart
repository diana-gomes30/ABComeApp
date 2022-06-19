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
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Para evitar o delay ao carregar a imagem de fundo
    precacheImage(const AssetImage(kBackgroundImagePath), context);

    return GlobalLoaderOverlay(
      child: MaterialApp(
        title: 'A.B.Come',
        theme: ThemeData(
          primaryColor: Colors.black,
          backgroundColor: Colors.white,
        ),
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
    );
  }
}

