import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/repositories/poll_repository.dart';
import 'package:abcome_app/screens/historic_page.dart';
import 'package:abcome_app/screens/home_page.dart';
import 'package:abcome_app/screens/members/members_page.dart';
import 'package:abcome_app/screens/poll/poll_page.dart';
import 'package:abcome_app/screens/poll/vote_page.dart';
import 'package:abcome_app/screens/results_page.dart';
import 'package:abcome_app/screens/settings_page.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class MyAppDrawer extends StatefulWidget {
  const MyAppDrawer({Key? key}) : super(key: key);

  @override
  State<MyAppDrawer> createState() => _MyAppDrawerState();
}

class _MyAppDrawerState extends State<MyAppDrawer> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Drawer(
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
                            color: kWhiteColor,
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
                        title: const Text('Membros'),
                        leading: const Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, MembersPage.id);
                        },
                      ),
                      ListTile(
                        title: const Text('Votação'),
                        leading: const Icon(
                          Icons.how_to_vote,
                          color: kPrimaryColor,
                        ),
                        onTap: () async {
                          setState(() => isLoading = true);
                          Poll? activePoll =
                              await PollRepository.readActivePoll();
                          setState(() => isLoading = false);
                          if (activePoll == null) {
                            Navigator.pushReplacementNamed(
                                context, PollPage.id);
                          } else {
                            Navigator.pushReplacementNamed(
                                context, VotePage.id);
                          }
                        },
                      ),
                      ListTile(
                        title: const Text('Resultados'),
                        leading: const Icon(
                          Icons.task,
                          color: kPrimaryColor,
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, ResultsPage.id);
                        },
                      ),
                      ListTile(
                        title: const Text('Histórico'),
                        leading: const Icon(
                          Icons.article,
                          color: kPrimaryColor,
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, HistoricPage.id);
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0.1,
                  color: kPrimaryColor,
                  indent: 10,
                  endIndent: 10,
                ),
                ListTile(
                  title: const Text('Definições'),
                  leading: const Icon(
                    Icons.settings,
                    color: kPrimaryColor,
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, SettingsPage.id);
                  },
                ),
              ],
            ),
          );
  }
}
