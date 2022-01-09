import 'package:abcome_app/components/my_app_bar.dart';
import 'package:abcome_app/components/my_app_drawer.dart';
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
      appBar: const MyAppBar(title: 'Membros'),
      drawer: const MyAppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {},
      ),
      body: Column(
        children: const [
          ListTile(
            title: Text('Person 1'),
            leading: Image(
              image: AssetImage('images/logotipo.png'),
            ),
          ),
          ListTile(
            title: Text('Person 2'),
            leading: Image(
              image: AssetImage('images/logotipo.png'),
            ),
          ),
          ListTile(
            title: Text('Person 3'),
            leading: Image(
              image: AssetImage('images/logotipo.png'),
            ),
          ),
          ListTile(
            title: Text('Person 4'),
            leading: Image(
              image: AssetImage('images/logotipo.png'),
            ),
          ),
          ListTile(
            title: Text('Person 5'),
            leading: Image(
              image: AssetImage('images/logotipo.png'),
            ),
          ),
          ListTile(
            title: Text('Person 6'),
            leading: Image(
              image: AssetImage('images/logotipo.png'),
            ),
          ),
          ListTile(
            title: Text('Person 7'),
            leading: Image(
              image: AssetImage('images/logotipo.png'),
            ),
          ),
          ListTile(
            title: Text('Person 8'),
            leading: Image(
              image: AssetImage('images/logotipo.png'),
            ),
          ),
          ListTile(
            title: Text('Person 9'),
            leading: Image(
              image: AssetImage('images/logotipo.png'),
            ),
          ),
          ListTile(
            title: Text('Person 10'),
            leading: Image(
              image: AssetImage('images/logotipo.png'),
            ),
          ),
        ],
      ),
    );
  }
}
