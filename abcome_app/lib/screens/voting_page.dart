import 'package:abcome_app/components/my_app_bar.dart';
import 'package:abcome_app/components/my_app_drawer.dart';
import 'package:flutter/material.dart';

class VotingPage extends StatefulWidget {
  const VotingPage({Key? key}) : super(key: key);
  static const String id = '/voting_page';

  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: 'Votação'),
        drawer: const MyAppDrawer(),
        body: Center(
          child: IconButton(
            icon: Image.asset('images/logotipo.png'),
            iconSize: 200,
            onPressed: () {  },
          ),
        ),
    );
  }
}
