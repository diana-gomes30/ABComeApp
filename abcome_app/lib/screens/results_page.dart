import 'package:abcome_app/models/statistic.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/repositories/poll_repository.dart';
import 'package:abcome_app/repositories/statistic_repository.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/widgets/custom_divider.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/person.dart';
import '../models/poll.dart';
import '../utils/utils.dart';

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
      for(Statistic statistic in statisticPresidentList) {
        Person? person = await PersonRepository.readById(statistic.personId);
        if (person != null) {
          bool havePerson = false; {
            for(Person p in personList) {
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
      for(Statistic statistic in statisticTreasurerList) {
        Person? person = await PersonRepository.readById(statistic.personId);
        if (person != null) {
          bool havePerson = false; {
            for(Person p in personList) {
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
          : (lastPoll == null || statisticPresidentList.isEmpty || statisticTreasurerList.isEmpty)
              ? Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: const Text(
                      'Não existe resultados para mostrar. Faça uma votação primeiro.',
                      style: TextStyle(
                        fontSize: 24,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                )
              : SafeArea(
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                padding: const EdgeInsets.all(20),
                                child: const Center(
                                  child: Text(
                                    'Presidente',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: statisticPresidentList.length,
                                itemBuilder: (context, index) {

                                  Person? person;
                                  for(Person p in personList) {
                                    if (p.id == statisticPresidentList[index].personId) {
                                      person = p.copy();
                                    }
                                  }

                                  double percentageNum = (statisticPresidentList[index].presidentNumVotes/lastPoll!.numPersons)*100;

                                  return Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            right: 30, left: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.065,
                                              child: ClipOval(
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: person!.image == ''
                                                      ? const Image(
                                                    image: AssetImage(kLogoImagePath),
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  )
                                                      : Utils.imageFromBase64String(
                                                    person.image,
                                                    width: 50.0,
                                                    height: 50.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.30,
                                              padding: const EdgeInsets.only(
                                                  top: 15, bottom: 15),
                                              child: Text(
                                                person.name,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.50,
                                              padding: const EdgeInsets.only(
                                                  top: 15,
                                                  bottom: 15,
                                                  right: 100),
                                              child: LinearPercentIndicator(
                                                animation: true,
                                                lineHeight: 20.0,
                                                animationDuration: 3000,
                                                percent: percentageNum/100,
                                                trailing:
                                                Text('(${statisticPresidentList[index].presidentNumVotes} Votos)'),
                                                center: Text(
                                                  '$percentageNum%',
                                                  style: const TextStyle(
                                                    color: kWhiteColor,
                                                  ),
                                                ),
                                                curve: Curves.easeInOut,
                                                barRadius:
                                                const Radius.circular(20.0),
                                                progressColor: kPrimaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const CustomDivider(),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                padding: const EdgeInsets.all(20),
                                child: const Center(
                                  child: Text(
                                    'Tesoureiro',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: statisticTreasurerList.length,
                                itemBuilder: (context, index) {

                                  Person? person;
                                  for(Person p in personList) {
                                    if (p.id == statisticTreasurerList[index].personId) {
                                      person = p.copy();
                                    }
                                  }
                                  double percentageNum = (statisticTreasurerList[index].treasurerNumVotes/lastPoll!.numPersons)*100;

                                  return Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            right: 30, left: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.065,
                                              child: ClipOval(
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: person!.image == ''
                                                      ? const Image(
                                                    image: AssetImage(kLogoImagePath),
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  )
                                                      : Utils.imageFromBase64String(
                                                    person.image,
                                                    width: 50.0,
                                                    height: 50.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.30,
                                              padding: const EdgeInsets.only(
                                                  top: 15, bottom: 15),
                                              child: Text(
                                                person.name,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.50,
                                              padding: const EdgeInsets.only(
                                                  top: 15,
                                                  bottom: 15,
                                                  right: 100),
                                              child: LinearPercentIndicator(
                                                animation: true,
                                                lineHeight: 20.0,
                                                animationDuration: 3000,
                                                percent: percentageNum/100,
                                                trailing: Text('(${statisticTreasurerList[index].treasurerNumVotes} Votos)'),
                                                center: Text(
                                                  '$percentageNum%',
                                                  style: const TextStyle(
                                                    color: kWhiteColor,
                                                  ),
                                                ),
                                                curve: Curves.easeInOut,
                                                barRadius:
                                                    const Radius.circular(20.0),
                                                progressColor: kPrimaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //Text('IdStatistic: ${statisticList[index].id} || PersonId: ${statisticList[index].personId} || PollId: ${statisticList[index].pollId} || NumPresidentVotes: ${statisticList[index].presidentNumVotes} || NumTreasurerVotes: ${statisticList[index].treasurerNumVotes}'),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

/*
Padding(
                padding: const EdgeInsets.all(15.0),
                child: LinearPercentIndicator(
                  //width: MediaQuery.of(context).size.width * 0.40 - 50,
                  animation: true,
                  lineHeight: 30.0,
                  animationDuration: 1000,
                  percent: 0.8,
                  center: const Text(
                    '80.0%',
                    style: TextStyle(
                      color: kWhiteColor,
                    ),
                  ),
                  curve: Curves.easeInOut,
                  barRadius: const Radius.circular(20.0),
                  progressColor: kPrimaryColor,
                ),
              ),
 */

/*child: ListView.builder(
                itemCount: statisticList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        'IdStatistic: ${statisticList[index].id} || PersonId: ${statisticList[index].personId} || PollId: ${statisticList[index].pollId} || NumPresidentVotes: ${statisticList[index].presidentNumVotes} || NumTreasurerVotes: ${statisticList[index].treasurerNumVotes}'),
                  );
                },
              ),*/
