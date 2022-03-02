import 'package:abcome_app/screens/home_page.dart';
import 'package:abcome_app/screens/loading_page.dart';
import 'package:abcome_app/screens/member_details_page.dart';
import 'package:abcome_app/screens/members_page.dart';
import 'package:abcome_app/screens/settings_page.dart';
import 'package:abcome_app/screens/voting_page.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Para evitar o delay ao carregar a imagem de fundo
    precacheImage(const AssetImage(kBackgroundImagePath), context);

    return MaterialApp(
      title: 'A.B.Come',
      theme: ThemeData(
        primaryColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      initialRoute: LoadingPage.id,
      routes: {
        LoadingPage.id: (context) => const LoadingPage(),
        HomePage.id: (context) => const HomePage(),
        VotingPage.id: (context) => const VotingPage(),
        MembersPage.id: (context) => const MembersPage(),
        MemberDetailsPage.id: (context) => const MemberDetailsPage(),
        SettingsPage.id: (context) => const SettingsPage(),
      },
    );
  }
}

