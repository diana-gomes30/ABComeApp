import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/repositories/mandate_repository.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/repositories/poll_repository.dart';
import 'package:abcome_app/repositories/statistic_repository.dart';
import 'package:abcome_app/responsive/mobile/poll/mobile_poll_page.dart';
import 'package:abcome_app/responsive/responsive_layout.dart';
import 'package:abcome_app/responsive/tablet/poll/tablet_poll_page.dart';
import 'package:abcome_app/screens/poll/vote_page.dart';
import 'package:abcome_app/widgets/custom_alert_dialog.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:flutter/material.dart';

class PollPage extends StatefulWidget {
  const PollPage({Key? key}) : super(key: key);
  static const String id = '/poll_page';

  @override
  _PollPageState createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  bool isLoading = false;

  List<Person> personsList = [];
  int numPersons = 0;
  late Poll currentPoll;

  bool value = true;

  @override
  void initState() {
    super.initState();

    getPersons();
  }

  Future<void> getPersons() async {
    setState(() => isLoading = true);

    personsList = await PersonRepository.readAll();
    int i = 0;
    for (Person person in personsList) {
      person.isVoting = 1;
      if (person.isVoting == 1) {
        i++;
      }
    }
    numPersons = i;

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Votação'),
      drawer: const MyAppDrawer(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: ResponsiveLayout(
                mobileBody: MobilePollPage(
                  personsList: personsList,
                  onClickCardPerson: (i) => onClickCardPerson(i),
                  onChangeCardValue: (i, newValue) => onChangeCardValue(i, newValue),
                  onClickCreatePoll: () => onClickCreatePoll(),
                ),
                tabletBody: TabletPollPage(
                  personsList: personsList,
                  onClickCardPerson: (i) => onClickCardPerson(i),
                  onChangeCardValue: (i, newValue) => onChangeCardValue(i, newValue),
                  onClickCreatePoll: () => onClickCreatePoll(),
                ),
              ),
            ),
    );
  }

  Future<void> onClickCardPerson(int i) async {
    setState(() {
      value = !value;
      personsList[i].isVoting = value ? 1 : 0;
    });
  }

  Future<void> onChangeCardValue(int i, bool newValue) async {
      setState(() {
          personsList[i].isVoting = newValue ? 1 : 0;
        },
      );
  }

  Future<void> onClickCreatePoll() async {
    setState(() => isLoading = true);
    int num = 0;
    for (Person p in personsList) {
      if (p.isVoting == 1) {
        num++;
      }
    }
    if (num > 0) {
      bool updated = await updatePersons();
      if (updated) {
        await insertUpdatePoll();
      }
      setState(() => isLoading = false);
    } else {
      return showDialog(
        context: context,
        builder: (context) {
          return const CustomAlertDialog(
            title: 'Atenção!',
            content:
            'Não é possível iniciar uma votação \nsem pessoas para votar.',
          );
        },
      ).whenComplete(() => setState(() => isLoading = false));
    }
  }

  Future<bool> updatePersons() async {
    try {
      int i = 0;
      for (Person person in personsList) {
        await PersonRepository.update(person);
        if (person.isVoting == 1) {
          i++;
        }
      }
      setState(() {
        numPersons = i;
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> insertUpdatePoll() async {
    int currentYear = DateTime.now().year;

    Poll? pollExists = await PollRepository.readByYear(currentYear);
    if (pollExists == null) {
      final poll = Poll(
        numPersons: numPersons,
        presidentId: 0,
        treasurerId: 0,
        year: currentYear,
        active: 1,
      );
      currentPoll = await PollRepository.insert(poll);
      Navigator.pushReplacementNamed(context, VotePage.id);
    } else {
      if (pollExists.active == 0) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              title: const Text('Atenção!'),
              content: const Text(
                  'Já foi feita uma votação para este ano. Tem \na certeza que quer apagá-la e fazer uma nova?'),
              actions: [
                TextButton(
                  onPressed: () {
                    bool value = false;
                    Navigator.pop(context, value);
                  },
                  child: const Text('Não'),
                ),
                TextButton(
                  onPressed: () async {
                    await MandateRepository.deleteByPoll(pollExists.id ?? 0);
                    await StatisticRepository.deleteByPoll(pollExists.id ?? 0);
                    await PollRepository.deleteById(pollExists.id ?? 0);

                    final poll = Poll(
                      numPersons: numPersons,
                      presidentId: 0,
                      treasurerId: 0,
                      year: currentYear,
                      active: 1,
                    );
                    currentPoll = await PollRepository.insert(poll);
                    bool value = true;
                    Navigator.pop(context, value);
                  },
                  child: const Text('Sim'),
                ),
              ],
            );
          },
        ).then((value) {
          if (value) {
            Navigator.pushNamed(context, VotePage.id);
          }
        });
      } else {
        final pollUpdated = pollExists.copy(
          numPersons: numPersons,
          presidentId: 0,
          treasurerId: 0,
        );
        currentPoll = await PollRepository.update(pollUpdated);
        Navigator.pushNamed(context, VotePage.id);
      }
    }
  }
}
