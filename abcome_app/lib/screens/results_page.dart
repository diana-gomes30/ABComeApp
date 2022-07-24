import 'package:abcome_app/models/statistic.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/repositories/poll_repository.dart';
import 'package:abcome_app/repositories/statistic_repository.dart';
import 'package:abcome_app/responsive/mobile/mobile_results_page.dart';
import 'package:abcome_app/responsive/responsive_layout.dart';
import 'package:abcome_app/responsive/tablet/tablet_results_page.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/widgets/center_text_message.dart';
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
      /*(lastPoll == null)
              ? const CenterTextMessage(
                  content:
                      'Não existe resultados para mostrar. Faça uma votação primeiro.',
                )
              : lastPoll!.active == 1
                  ? const CenterTextMessage(
                      content:
                          'Não existe resultados para mostrar. Termine a votação primeiro.',
                    )
                  : statisticPresidentList.isEmpty ||
                          statisticTreasurerList.isEmpty
                      ? const CenterTextMessage(
                          content:
                              'Não existe resultados para mostrar. Faça uma votação primeiro.',
                        )
                      : SafeArea(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.15,
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        statisticPresidentList.length,
                                    itemBuilder: (context, index) {
                                      int position = 0;
                                      if (index > 0 &&
                                          statisticPresidentList[index]
                                                  .presidentNumVotes ==
                                              statisticPresidentList[
                                                      index - 1]
                                                  .presidentNumVotes) {
                                        position = lastPositionPresident;
                                      } else {
                                        position =
                                            lastPositionPresident + 1;
                                        lastPositionPresident = position;
                                      }

                                      Person? person;
                                      for (Person p in personList) {
                                        if (p.id ==
                                            statisticPresidentList[index]
                                                .personId) {
                                          person = p.copy();
                                        }
                                      }

                                      double percentageNum =
                                          (statisticPresidentList[index]
                                                      .presidentNumVotes /
                                                  lastPoll!.numPersons) *
                                              100;

                                      return Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 30, left: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          10),
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.065,
                                                  child: ClipOval(
                                                    child: Material(
                                                      color: Colors
                                                          .transparent,
                                                      child: person!
                                                                  .image ==
                                                              ''
                                                          ? const Image(
                                                              image: AssetImage(
                                                                  kLogoImagePath),
                                                              width: 50,
                                                              height: 50,
                                                              fit: BoxFit
                                                                  .cover,
                                                            )
                                                          : Utils
                                                              .imageFromBase64String(
                                                              person.image,
                                                              width: 50.0,
                                                              height: 50.0,
                                                              fit: BoxFit
                                                                  .cover,
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.20,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15,
                                                          bottom: 15),
                                                  child: Text(
                                                    person.name,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '$positionº',
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                                Container(
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.50,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15,
                                                          bottom: 15,
                                                          right: 100),
                                                  child:
                                                      LinearPercentIndicator(
                                                    animation: true,
                                                    lineHeight: 20.0,
                                                    animationDuration: 3000,
                                                    percent:
                                                        percentageNum / 100,
                                                    trailing: Text(
                                                        '(${statisticPresidentList[index].presidentNumVotes} Votos)'),
                                                    center: Text(
                                                      '${percentageNum.toStringAsFixed(2)}%',
                                                      style:
                                                          const TextStyle(
                                                        color: kWhiteColor,
                                                      ),
                                                    ),
                                                    curve: Curves.easeInOut,
                                                    barRadius: const Radius
                                                        .circular(20.0),
                                                    progressColor:
                                                        kPrimaryColor,
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
                                        MediaQuery.of(context).size.height *
                                            0.15,
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        statisticTreasurerList.length,
                                    itemBuilder: (context, index) {
                                      int position = 0;
                                      if (index > 0 &&
                                          statisticTreasurerList[index]
                                                  .treasurerNumVotes ==
                                              statisticTreasurerList[
                                                      index - 1]
                                                  .treasurerNumVotes) {
                                        position = lastPositionTreasurer;
                                      } else {
                                        position =
                                            lastPositionTreasurer + 1;
                                        lastPositionTreasurer = position;
                                      }

                                      Person? person;
                                      for (Person p in personList) {
                                        if (p.id ==
                                            statisticTreasurerList[index]
                                                .personId) {
                                          person = p.copy();
                                        }
                                      }
                                      double percentageNum =
                                          (statisticTreasurerList[index]
                                                      .treasurerNumVotes /
                                                  lastPoll!.numPersons) *
                                              100;

                                      return Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 30, left: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          10),
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.065,
                                                  child: ClipOval(
                                                    child: Material(
                                                      color: Colors
                                                          .transparent,
                                                      child: person!
                                                                  .image ==
                                                              ''
                                                          ? const Image(
                                                              image: AssetImage(
                                                                  kLogoImagePath),
                                                              width: 50,
                                                              height: 50,
                                                              fit: BoxFit
                                                                  .cover,
                                                            )
                                                          : Utils
                                                              .imageFromBase64String(
                                                              person.image,
                                                              width: 50.0,
                                                              height: 50.0,
                                                              fit: BoxFit
                                                                  .cover,
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.20,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15,
                                                          bottom: 15),
                                                  child: Text(
                                                    person.name,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '$positionº',
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                                Container(
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.50,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15,
                                                          bottom: 15,
                                                          right: 100),
                                                  child:
                                                      LinearPercentIndicator(
                                                    animation: true,
                                                    lineHeight: 20.0,
                                                    animationDuration: 3000,
                                                    percent:
                                                        percentageNum / 100,
                                                    trailing: Text(
                                                        '(${statisticTreasurerList[index].treasurerNumVotes} Votos)'),
                                                    center: Text(
                                                      '${percentageNum.toStringAsFixed(2)}%',
                                                      style:
                                                          const TextStyle(
                                                        color: kWhiteColor,
                                                      ),
                                                    ),
                                                    curve: Curves.easeInOut,
                                                    barRadius: const Radius
                                                        .circular(20.0),
                                                    progressColor:
                                                        kPrimaryColor,
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
                        ),*/
    );
  }
}
