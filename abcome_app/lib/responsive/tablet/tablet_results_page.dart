import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/models/statistic.dart';
import 'package:abcome_app/widgets/tablet/build_president_results_list_tablet.dart';
import 'package:abcome_app/widgets/tablet/build_treasurer_results_list_tablet.dart';
import 'package:abcome_app/widgets/center_text_message.dart';
import 'package:abcome_app/widgets/custom_divider.dart';
import 'package:abcome_app/widgets/title_results_page.dart';
import 'package:flutter/material.dart';

class TabletResultsPage extends StatelessWidget {
  const TabletResultsPage({
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
                            buildPresidentResultsListTablet(
                              lastPositionPresident,
                              statisticPresidentList,
                              personList,
                              lastPoll!.numPersons,
                            ),
                            const CustomDivider(),
                            const TitleResultsPage(
                              title: 'Tesoureiro',
                            ),
                            buildTreasurerResultsListTablet(
                              lastPositionTreasurer,
                              statisticTreasurerList,
                              personList,
                              lastPoll!.numPersons,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
  }
}