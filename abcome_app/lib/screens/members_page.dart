import 'package:abcome_app/components/app_drawer.dart';
import 'package:flutter/material.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({Key? key}) : super(key: key);
  static const String id = '/members';

  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Membros'),
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
