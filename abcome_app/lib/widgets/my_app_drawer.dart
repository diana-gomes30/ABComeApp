import 'package:abcome_app/screens/home_page.dart';
import 'package:abcome_app/screens/members_page.dart';
import 'package:abcome_app/screens/voting_page.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Center(
              child: Column(
                children: const [
                  Image(
                    image: AssetImage(kLogoImagePath),
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'A.B.Come',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Início'),
            leading: const Icon(
              Icons.home,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomePage.id);
            },
          ),
          ListTile(
            title: const Text('Votação'),
            leading: const Icon(
              Icons.how_to_vote,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, VotingPage.id);
            },
          ),
          ListTile(
            title: const Text('Membros'),
            leading: const Icon(
              Icons.person,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, MembersPage.id);
              },
          ),
        ],
      ),
    );
  }
}