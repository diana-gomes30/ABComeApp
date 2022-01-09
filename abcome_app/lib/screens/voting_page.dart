import 'package:abcome_app/components/app_drawer.dart';
import 'package:flutter/material.dart';

class VotingPage extends StatefulWidget {
  const VotingPage({Key? key}) : super(key: key);
  static const String id = '/voting';

  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Votação'),
        ),
        drawer: const AppDrawer(),
        body: Center(
          child: IconButton(
            icon: Image.asset('images/logotipo.jpg'),
            iconSize: 200,
            onPressed: () {  },
          ),
        ),
    );
  }
}
