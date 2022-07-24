import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/models/statistic.dart';
import 'package:abcome_app/widgets/mobile/build_president_results_list_mobile.dart';
import 'package:abcome_app/widgets/center_text_message.dart';
import 'package:abcome_app/widgets/custom_divider.dart';
import 'package:abcome_app/widgets/mobile/build_treasurer_results_list_mobile.dart';
import 'package:abcome_app/widgets/title_results_page.dart';
import 'package:flutter/material.dart';

class MobileResultsPage extends StatelessWidget {
  const MobileResultsPage({
    Key? key,
    this.lastPoll,
    required this.statisticPresidentList,
    required this.statisticTreasurerList,
    required this.personList,
  }) : super(key: key);

  final Poll? lastPoll;
  final List<Statistic> statisticPresidentList;
  final List<Statistic> statisticTreasurerList;
  final List<Person> personList;

  @override
  Widget build(BuildContext context) {
    int lastPositionPresident = 0;
    int lastPositionTreasurer = 0;

    return (lastPoll == null)
        ? const CenterTextMessage(
            content:
                'Não existe resultados para mostrar. Faça uma votação primeiro.',
          )
        : lastPoll!.active == 1
            ? const CenterTextMessage(
                content:
                    'Não existe resultados para mostrar. Termine a votação primeiro.',
              )
            : statisticPresidentList.isEmpty || statisticTreasurerList.isEmpty
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
                            const TitleResultsPage(
                              title: 'Presidente',
                            ),
                            buildPresidentResultsListMobile(
                              lastPositionPresident,
                              statisticPresidentList,
                              personList,
                              lastPoll!.numPersons,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 15),
                            ),
                            const CustomDivider(),
                            const TitleResultsPage(
                              title: 'Tesoureiro',
                            ),
                            buildTreasurerResultsListMobile(
                              lastPositionTreasurer,
                              statisticTreasurerList,
                              personList,
                              lastPoll!.numPersons,
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
  }
}
