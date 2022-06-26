import 'dart:async';

import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/models/statistic.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/repositories/poll_repository.dart';
import 'package:abcome_app/repositories/statistic_repository.dart';
import 'package:abcome_app/screens/home_page.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/widgets/custom_alert_dialog.dart';
import 'package:abcome_app/widgets/custom_divider.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VotePage extends StatefulWidget {
  const VotePage({Key? key}) : super(key: key);
  static const String id = '/vote_page';

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  final TextEditingController _personController = TextEditingController();
  final TextEditingController _presidentController = TextEditingController();
  final TextEditingController _treasurerController = TextEditingController();

  bool isLoading = false;

  List<Person> personsList = [];
  late Person person;
  List<Person> presidentsList = [];
  late Person president;
  List<Person> treasurersList = [];
  late Person treasurer;

  Poll? currentPoll;

  @override
  void initState() {
    super.initState();

    getData();
    getCurrentPoll();
  }

  Future<void> getData() async {
    setState(() => isLoading = true);

    personsList = await PersonRepository.readCanVote();
    presidentsList = await PersonRepository.readAll();
    treasurersList = await PersonRepository.readAll();

    setState(() => isLoading = false);
  }

  Future<void> getCurrentPoll() async {
    setState(() => isLoading = true);

    currentPoll = (await PollRepository.readActivePoll())!;

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: const MyAppBar(title: 'Votação'),
            drawer: const MyAppDrawer(),
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: Text(
                          'Votação ${currentPoll != null ? currentPoll!.year : DateTime.now().year}',
                          style: const TextStyle(
                            fontSize: 30,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        margin: const EdgeInsets.symmetric(vertical: 15.0),
                        padding: const EdgeInsets.symmetric(
                          //horizontal: 20.0,
                          vertical: 5.0,
                        ),
                        decoration: textBoxDecoration.copyWith(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            setState(() => isLoading = true);
                            await _showListPersonsDialog(
                              'Selecione o seu nome',
                              personsList,
                              true,
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  final Person personVoting = value;
                                  person = personVoting.copy();
                                  print('Person: ${person.id}');
                                  _personController.text = person.name;
                                });
                              }
                            });
                            setState(() => isLoading = false);
                          },
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  enabled: false,
                                  controller: _personController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Selecione o seu nome',
                                    hintStyle: TextStyle(
                                      fontSize: 16.0,
                                      color: kPrimaryColor.withOpacity(0.5),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        FontAwesomeIcons.user,
                                        color: kPrimaryColor,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.arrow_drop_down),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        margin: const EdgeInsets.symmetric(vertical: 15.0),
                        padding: const EdgeInsets.symmetric(
                          //horizontal: 20.0,
                          vertical: 5.0,
                        ),
                        decoration: textBoxDecoration.copyWith(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            setState(() => isLoading = true);
                            await _showListPersonsDialog(
                              'Selecione o Presidente',
                              presidentsList,
                              false,
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  final Person presidentVoted = value;
                                  president = presidentVoted.copy();
                                  print('President: ${president.id}');
                                  _presidentController.text = president.name;
                                });
                              }
                            });
                            setState(() => isLoading = false);
                          },
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  enabled: false,
                                  controller: _presidentController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Selecione o Presidente',
                                    hintStyle: TextStyle(
                                      fontSize: 16.0,
                                      color: kPrimaryColor.withOpacity(0.5),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        FontAwesomeIcons.user,
                                        color: kPrimaryColor,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.arrow_drop_down),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        margin: const EdgeInsets.symmetric(vertical: 15.0),
                        padding: const EdgeInsets.symmetric(
                          //horizontal: 20.0,
                          vertical: 5.0,
                        ),
                        decoration: textBoxDecoration.copyWith(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            setState(() => isLoading = true);
                            await _showListPersonsDialog(
                              'Selecione o Tesoureiro',
                              treasurersList,
                              false,
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  final Person treasurerVoted = value;
                                  treasurer = treasurerVoted.copy();
                                  print('Treasurer: ${treasurer.id}');
                                  _treasurerController.text = treasurer.name;
                                });
                              }
                            });
                            setState(() => isLoading = false);
                          },
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  enabled: false,
                                  controller: _treasurerController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Selecione o Tesoureiro',
                                    hintStyle: TextStyle(
                                      fontSize: 16.0,
                                      color: kPrimaryColor.withOpacity(0.5),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        FontAwesomeIcons.user,
                                        color: kPrimaryColor,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.arrow_drop_down),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(30),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (_personController.text != '') {
                              if (_presidentController.text != '' &&
                                  _treasurerController.text != '') {
                                if (_presidentController.text !=
                                    _treasurerController.text) {
                                  if (president.wasPresident == 1 ||
                                      president.wasTreasurer == 1 ||
                                      treasurer.wasPresident == 1 ||
                                      treasurer.wasTreasurer == 1) {
                                    return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const CustomAlertDialog(
                                          title: 'Atenção!',
                                          content:
                                              'Não é possível votar em alguém que \njá tenha sido presidente ou tesoureiro.',
                                        );
                                      },
                                    );
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.0),
                                            ),
                                          ),
                                          title: const Text('Aviso'),
                                          content: const Text(
                                              'Deseja confirmar o seu voto?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Não'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                setState(
                                                    () => isLoading = true);
                                                await insertUpdateStatistic();
                                                await updatePerson();
                                                await getData();
                                                _personController.text = '';
                                                _presidentController.text = '';
                                                _treasurerController.text = '';
                                                setState(
                                                    () => isLoading = false);

                                                if (personsList.isEmpty) {
                                                  setState(
                                                      () => isLoading = true);
                                                  await closePoll();
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, HomePage.id);
                                                  setState(
                                                      () => isLoading = false);
                                                } else {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Text('Sim'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                } else {
                                  return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const CustomAlertDialog(
                                        title: 'Atenção!',
                                        content:
                                            'Não é possível votar na mesma pessoa para \npresidente e tesoureiro.',
                                      );
                                    },
                                  );
                                }
                              } else {
                                return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const CustomAlertDialog(
                                      title: 'Atenção!',
                                      content:
                                          'Não é permitido votos em branco. Verifique \nse selecionou um presidente e um tesoureiro.',
                                    );
                                  },
                                );
                              }
                            } else {
                              return showDialog(
                                context: context,
                                builder: (context) {
                                  return const CustomAlertDialog(
                                    title: 'Atenção!',
                                    content:
                                        'Para votar tem que selecionar o seu nome.',
                                  );
                                },
                              );
                            }
                          },
                          child: const Text(
                            'Confirmar',
                            style: TextStyle(fontSize: 20, color: kWhiteColor),
                          ),
                        ),
                      ),
                      Container(
                        //margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  title: const Text('Aviso'),
                                  content: const Text(
                                      'Tem a certeza que quer cancelar a votação?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Não'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        setState(() => isLoading = true);
                                        await StatisticRepository.deleteByPoll(
                                            currentPoll!.id ?? 0);
                                        await PollRepository.deleteById(
                                            currentPoll!.id ?? 0);
                                        await PersonRepository
                                            .updateVotingField();
                                        setState(() => isLoading = true);
                                        Navigator.pushReplacementNamed(
                                            context, HomePage.id);
                                      },
                                      child: const Text('Sim'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(fontSize: 20, color: kWhiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Future<dynamic> _showListPersonsDialog(
          String title, List<Person> namesList, bool isPersonVoting) async =>
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(left: 25, right: 25),
            title: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: kPrimaryColor,
                ),
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            content: SizedBox(
              height: namesList.isEmpty ? 150 : 350,
              width: 400,
              child: namesList.isEmpty
                  ? const Center(
                      child: Text(
                          'Não foi possível encontrar membros. Por favor, verifique se tem membros adicionados à aplicação.'),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10.0),
                          for (var i in namesList)
                            Column(
                              children: [
                                const CustomDivider(
                                  start: 40.0,
                                  end: 40.0,
                                ),
                                ListTile(
                                  title: Center(
                                    child: Text(
                                      i.name,
                                      style: TextStyle(
                                        color: isPersonVoting
                                            ? kPrimaryColor
                                            : (i.wasPresident == 1 ||
                                                    i.wasTreasurer == 1)
                                                ? kSecondaryColor
                                                : kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context, i);
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );

  /*Future<void> insertVote() async {
    final vote = Vote(
      personId: person.id ?? 0,
      pollId: currentPoll!.id ?? 0,
      presidentId: president.id ?? 0,
      treasurerId: treasurer.id ?? 0,
    );

    await VoteRepository.insert(vote);
  }*/

  Future<void> insertUpdateStatistic() async {
    // Verifica se já existe um registo para o ID do presidente, se sim, atualiza numVotos se não cria um registo novo
    Statistic? statisticPresidentExists = await StatisticRepository.readByPersonPoll(
        president.id ?? 0, currentPoll!.id ?? 0);

    if (statisticPresidentExists == null) {
      final statisticPresident = Statistic(
          personId:  president.id ?? 0,
          pollId: currentPoll!.id ?? 0,
          presidentNumVotes: 1,
          treasurerNumVotes: 0,
      );

      await StatisticRepository.insert(statisticPresident);
    } else {
      int numVotes = statisticPresidentExists.presidentNumVotes + 1;
      final statisticPresident = statisticPresidentExists.copy(
        presidentNumVotes: numVotes,
      );

      await StatisticRepository.update(statisticPresident);
    }

    // Verifica se já existe um registo para o ID do tesoureiro, se sim, atualiza numVotos se não cria um registo novo
    Statistic? statisticTreasurerExists = await StatisticRepository.readByPersonPoll(
        treasurer.id ?? 0, currentPoll!.id ?? 0);

    if (statisticTreasurerExists == null) {
      final statisticTreasurer = Statistic(
        personId:  treasurer.id ?? 0,
        pollId: currentPoll!.id ?? 0,
        presidentNumVotes: 0,
        treasurerNumVotes: 1,
      );

      await StatisticRepository.insert(statisticTreasurer);
    } else {
      int numVotes = statisticTreasurerExists.treasurerNumVotes + 1;
      final statisticTreasurer = statisticTreasurerExists.copy(
        treasurerNumVotes: numVotes,
      );

      await StatisticRepository.update(statisticTreasurer);
    }
  }

  Future<void> updatePerson() async {
    final personUpdated = person.copy(
      isVoting: 0,
    );

    await PersonRepository.update(personUpdated);
  }

  Future<void> closePoll() async {
    final pollUpdated = currentPoll!.copy(
      active: 0,
    );

    await PollRepository.update(pollUpdated);
  }
}
