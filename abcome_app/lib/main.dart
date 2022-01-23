import 'package:abcome_app/screens/home_page.dart';
import 'package:abcome_app/screens/member_details_page.dart';
import 'package:abcome_app/screens/members_page.dart';
import 'package:abcome_app/screens/voting_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A.B.Come',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => const HomePage(),
        VotingPage.id: (context) => const VotingPage(),
        MembersPage.id: (context) => const MembersPage(),
        MemberDetailsPage.id: (context) => const MemberDetailsPage(),
      },
    );
  }
}

