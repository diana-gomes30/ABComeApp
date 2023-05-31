import 'package:abcome_app/models/statistic.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/repositories/poll_repository.dart';
import 'package:abcome_app/repositories/statistic_repository.dart';
import 'package:abcome_app/responsive/mobile/mobile_results_page.dart';
import 'package:abcome_app/responsive/responsive_layout.dart';
import 'package:abcome_app/responsive/tablet/tablet_results_page.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:flutter/material.dart';
import '../models/person.dart';
import '../models/poll.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);
  static const String id = '/results_page';

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  bool isLoading = false;

  Poll? lastPoll;

  List<Statistic> statisticPresidentList = [];
  List<Statistic> statisticTreasurerList = [];
  List<Person> personList = [];

  int lastPositionPresident = 0;
  int lastPositionTreasurer = 0;

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<void> getData() async {
    setState(() => isLoading = true);

    lastPoll = await PollRepository.readLast();
    if (lastPoll != null) {
      statisticPresidentList =
          await StatisticRepository.readPresidentByPoll(lastPoll!.id ?? 0);
      for (Statistic statistic in statisticPresidentList) {
        Person? person = await PersonRepository.readById(statistic.personId);
        if (person != null) {
          bool havePerson = false;
          {
            for (Person p in personList) {
              if (person.id == p.id) {
                havePerson = true;
              }
            }

            if (havePerson == false) {
              personList.add(person);
            }
          }
        }
      }

      statisticTreasurerList =
          await StatisticRepository.readTreasurerByPoll(lastPoll!.id ?? 0);
      for (Statistic statistic in statisticTreasurerList) {
        Person? person = await PersonRepository.readById(statistic.personId);
        if (person != null) {
          bool havePerson = false;
          {
            for (Person p in personList) {
              if (person.id == p.id) {
                havePerson = true;
              }
            }

            if (havePerson == false) {
              personList.add(person);
            }
          }
        }
      }
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Resultados',
      ),
      drawer: const MyAppDrawer(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ResponsiveLayout(
              mobileBody: MobileResultsPage(
                lastPoll: lastPoll,
                statisticPresidentList: statisticPresidentList,
                statisticTreasurerList: statisticTreasurerList,
                personList: personList,
              ),
              tabletBody: TabletResultsPage(
                lastPoll: lastPoll,
                statisticPresidentList: statisticPresidentList,
                statisticTreasurerList: statisticTreasurerList,
                personList: personList,
              ),
            ),
    );
  }
}
