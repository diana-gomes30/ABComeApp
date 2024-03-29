import 'dart:async';
import 'package:abcome_app/models/mandate.dart';
import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/models/statistic.dart';
import 'package:abcome_app/repositories/mandate_repository.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/repositories/poll_repository.dart';
import 'package:abcome_app/repositories/statistic_repository.dart';
import 'package:abcome_app/responsive/mobile/poll/mobile_vote_page.dart';
import 'package:abcome_app/responsive/responsive_layout.dart';
import 'package:abcome_app/responsive/tablet/poll/tablet_vote_page.dart';
import 'package:abcome_app/screens/home_page.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/widgets/custom_alert_dialog.dart';
import 'package:abcome_app/widgets/custom_divider.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

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

  List<Widget> actions = [];

  @override
  void initState() {
    super.initState();

    getData();
    getCurrentPoll();
  }

  Future<void> getData() async {
    setState(() => isLoading = true);

    if (actions.isEmpty) {
      await getAppbarAction();
    }

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

  Future<void> getAppbarAction() async {
    var appBarHeight = AppBar().preferredSize.height;

    Widget cancelPollButton = PopupMenuButton<int>(
      onSelected: (value) {
        if (value == 1) {
          onClickCancelPoll();
        }
      },
      offset: Offset(0.0, appBarHeight),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                ),
              ),
              Text('Cancelar Votação'),
            ],
          ),
        )
      ],
    );

    actions.add(cancelPollButton);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: MyAppBar(
              title: 'Votação',
              actions: actions,
            ),
            drawer: const MyAppDrawer(),
            body: ResponsiveLayout(
              mobileBody: MobileVotePage(
                year: currentPoll!.year,
                personController: _personController,
                presidentController: _presidentController,
                treasurerController: _treasurerController,
                onClickPerson: onClickPerson,
                onClickPresident: onClickPresident,
                onClickTreasurer: onClickTreasurer,
                onClickConfirmVote: onClickConfirmVote,
                onClickCancelPoll: onClickCancelPoll,
              ),
              tabletBody: TabletVotePage(
                year: currentPoll!.year,
                personController: _personController,
                presidentController: _presidentController,
                treasurerController: _treasurerController,
                onClickPerson: onClickPerson,
                onClickPresident: onClickPresident,
                onClickTreasurer: onClickTreasurer,
                onClickConfirmVote: onClickConfirmVote,
                onClickCancelPoll: onClickCancelPoll,
              ),
            ),
          );
  }

  Future<void> onClickPerson() async {
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
          _personController.text = person.name;
        });
      }
    });
    setState(() => isLoading = false);
  }

  Future<void> onClickPresident() async {
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
          _presidentController.text = president.name;
        });
      }
    });
    setState(() => isLoading = false);
  }

  Future<void> onClickTreasurer() async {
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
          _treasurerController.text = treasurer.name;
        });
      }
    });
    setState(() => isLoading = false);
  }

  Future<void> onClickConfirmVote() async {
    if (_personController.text != '') {
      if (_presidentController.text != '' && _treasurerController.text != '') {
        if (_presidentController.text != _treasurerController.text) {
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
                  content: const Text('Deseja confirmar o seu voto?'),
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
                        await insertUpdateStatistic();
                        await updatePerson();
                        await getData();
                        _personController.text = '';
                        _presidentController.text = '';
                        _treasurerController.text = '';
                        setState(() => isLoading = false);

                        if (personsList.isEmpty) {
                          setState(() => isLoading = true);
                          await updateInsertMandate();
                          await closePoll();
                          Navigator.pushReplacementNamed(context, HomePage.id);
                          setState(() => isLoading = false);
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
            content: 'Para votar tem que selecionar o seu nome.',
          );
        },
      );
    }
  }

  Future<void> onClickCancelPoll() async {
    await showDialog(
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
              'Tem a certeza que quer cancelar a votação e apagar todos os votos já feitos?'),
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
                await MandateRepository.deleteByPoll(currentPoll!.id ?? 0);
                await StatisticRepository.deleteByPoll(currentPoll!.id ?? 0);
                await PollRepository.deleteById(currentPoll!.id ?? 0);
                await PersonRepository.updateVotingField();
                setState(() => isLoading = true);
                Navigator.pushReplacementNamed(context, HomePage.id);
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _showListPersonsDialog(
          String title, List<Person> personsList, bool isPersonVoting) async =>
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
              height: personsList.isEmpty ? 150 : 350,
              width: 400,
              child: personsList.isEmpty
                  ? const Center(
                      child: Text(
                          'Não foi possível encontrar membros. Por favor, verifique se tem membros adicionados à aplicação.'),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10.0),
                          for (var i in personsList)
                            Column(
                              children: [
                                const CustomDivider(
                                  start: 0,
                                  end: 0,
                                ),
                                ListTile(
                                  leading: ClipOval(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: i.image == ''
                                          ? const Image(
                                              image: AssetImage(kLogoImagePath),
                                              fit: BoxFit.cover,
                                              width: 50,
                                              height: 50,
                                            )
                                          : Utils.imageFromBase64String(
                                              i.image,
                                              fit: BoxFit.cover,
                                              width: 50,
                                              height: 50,
                                            ),
                                    ),
                                  ),
                                  title: Center(
                                    child: Text(
                                      i.name,
                                      maxLines: 4,
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

  Future<void> insertUpdateStatistic() async {
    // Verifica se já existe um registo para o ID do presidente, se sim, atualiza numVotos se não cria um registo novo
    Statistic? statisticPresidentExists =
        await StatisticRepository.readByPersonPoll(
            president.id ?? 0, currentPoll!.id ?? 0);

    if (statisticPresidentExists == null) {
      final statisticPresident = Statistic(
        personId: president.id ?? 0,
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
    Statistic? statisticTreasurerExists =
        await StatisticRepository.readByPersonPoll(
            treasurer.id ?? 0, currentPoll!.id ?? 0);

    if (statisticTreasurerExists == null) {
      final statisticTreasurer = Statistic(
        personId: treasurer.id ?? 0,
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

  Future<void> updateInsertMandate() async {
    int personLimitFinal = 0;
    Mandate? mandateActive = await MandateRepository.readActive();
    if (mandateActive != null) {
      Mandate mandateClose = mandateActive.copy(
        active: 0,
      );

      await MandateRepository.update(mandateClose);

      personLimitFinal = mandateActive.personLimit;
    } else {
      personLimitFinal = 20;
    }
    List<Statistic?> statisticsPresident =
        await StatisticRepository.readPresidentByPoll(currentPoll!.id ?? 0);
    int idPresident = statisticsPresident.isNotEmpty ? statisticsPresident.first!.personId : 0;

    List<Statistic?> statisticsTreasurer =
        await StatisticRepository.readTreasurerByPoll(currentPoll!.id ?? 0);
    int idTreasurer = statisticsTreasurer.isNotEmpty ? statisticsTreasurer.first!.personId : 0;

    final Mandate mandateInserted = Mandate(
      personLimit: personLimitFinal,
      presidentId: idPresident,
      treasurerId: idTreasurer,
      active: 1,
      pollId: currentPoll!.id ?? 0,
    );
    await MandateRepository.insert(mandateInserted);
  }
}
