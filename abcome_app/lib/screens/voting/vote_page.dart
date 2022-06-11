import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/repositories/poll_repository.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
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
  bool isPresident = true;
  bool value = true;

  // Listas para controlar as pessoas que vão votar
  List<Person> personList = [];
  List<String> personNames = [];

  // Listas para controlar o presidente a ser eleito
  List<Person> presidentList = [];
  List<String> presidentNames = [];

  // Listas para controlar o tesoureiro a ser eleito
  List<Person> treasurerList = [];
  List<String> treasurerNames = [];

  Poll? currentPoll;

  @override
  void initState() {
    super.initState();

    getData();
    getCurrentPoll();
  }

  Future<void> getData() async {
    setState(() => isLoading = true);

    personList = await PersonRepository.readCanVote();
    for (Person person in personList) {
      personNames.add(person.name);
    }

    presidentList = await PersonRepository.readAll();
    for (Person person in presidentList) {
      presidentNames.add(person.name);
    }

    treasurerList = await PersonRepository.readAll();
    for (Person person in treasurerList) {
      treasurerNames.add(person.name);
    }

    setState(() => isLoading = false);
  }

  Future<void> getCurrentPoll() async {
    setState(() => isLoading = true);

    currentPoll = (await PollRepository.readCurrentPoll())!;

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
                              personNames,
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  final String username = value.toString();
                                  _personController.text = username;
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
                              presidentNames,
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  final String username = value.toString();
                                  _presidentController.text = username;
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
                              treasurerNames,
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  final String username = value.toString();
                                  _treasurerController.text = username;
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
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Sim'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Confirmar',
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
          String title, List<String> nameList) async =>
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
              height: nameList.isEmpty ? 150 : 350,
              width: 400,
              child: nameList.isEmpty
                  ? const Center(
                      child: Text(
                          'Não foi possível encontrar membros. Por favor, verifique se tem membros adicionados à aplicação.'),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10.0),
                          for (var i in nameList)
                            Column(
                              children: [
                                const Divider(
                                  height: 1.0,
                                  indent: 30.0,
                                  endIndent: 30.0,
                                  color: kPrimaryColor,
                                ),
                                ListTile(
                                  title: Center(child: Text(i)),
                                  onTap: () {
                                    final String username;
                                    username = i;
                                    Navigator.pop(context, username);
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
}
