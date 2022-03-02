import 'package:abcome_app/screens/home_page.dart';
import 'package:abcome_app/screens/members_page.dart';
import 'package:abcome_app/screens/settings_page.dart';
import 'package:abcome_app/screens/voting_page.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Column(
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
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: const Text('Início'),
                    leading: const Icon(
                      Icons.home,
                      color: kPrimaryColor,
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, HomePage.id);
                    },
                  ),
                  ListTile(
                    title: const Text('Votação'),
                    leading: const Icon(
                      Icons.how_to_vote,
                      color: kPrimaryColor,
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, VotingPage.id);
                    },
                  ),
                  ListTile(
                    title: const Text('Membros'),
                    leading: const Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, MembersPage.id);
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Divider(
                height: 0.1,
                color: kPrimaryColor,
                indent: 10,
                endIndent: 10,
              ),
            ),
            Container(
              //padding: EdgeInsets.all(10),
              child: ListTile(
                title: const Text('Definições'),
                leading: const Icon(
                  Icons.settings,
                  color: kPrimaryColor,
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, SettingsPage.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
