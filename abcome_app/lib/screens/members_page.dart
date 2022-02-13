import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'member_details_page.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({Key? key}) : super(key: key);
  static const String id = '/members_page';

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
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          color: kSecondaryColor,
        ),
        onPressed: () {
          Navigator.pushNamed(context, MemberDetailsPage.id);
        },
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
