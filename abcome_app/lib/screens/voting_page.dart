import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
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
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.20,
                child: CheckboxListTile(
                  title: Text('Member 1'),
                  controlAffinity: ListTileControlAffinity.platform,
                  value: true,
                  onChanged: (value) { },
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Iniciar uma nova votação'),
              ),
            ],
          ),
          /* IconButton(
              icon: Image.asset(kLogoImagePath),
              iconSize: 200,
              onPressed: () {  },
            ),*/
        ),
      ),
    );
  }
}
