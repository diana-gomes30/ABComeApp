import 'package:abcome_app/models/mandate.dart';
import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/repositories/mandate_repository.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/repositories/poll_repository.dart';
import 'package:abcome_app/responsive/mobile/mobile_settings_page.dart';
import 'package:abcome_app/responsive/responsive_layout.dart';
import 'package:abcome_app/responsive/tablet/tablet_settings_page.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const String id = '/settings_page';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLoading = false;
  late TextEditingController memberslimitController;
  late TextEditingController presidentController;
  late TextEditingController treasurerController;

  List<Person> personsList = [];

  Mandate? currentMandate;
  Poll? currentPoll;
  Person? currentPresident;
  Person? currentTreasurer;

  @override
  void initState() {
    super.initState();

    memberslimitController = TextEditingController(text: '');
    presidentController = TextEditingController(text: '');
    treasurerController = TextEditingController(text: '');
    refreshData();
  }

  @override
  void dispose() {
    memberslimitController.dispose();
    presidentController.dispose();
    treasurerController.dispose();

    super.dispose();
  }

  Future<void> refreshData() async {
    setState(() => isLoading = true);

    currentMandate = await MandateRepository.readActive();
    currentMandate ??= await MandateRepository.readLast();

    if (currentMandate != null) {
      memberslimitController.text = '${currentMandate!.personLimit}';
      currentPoll = await PollRepository.readById(currentMandate!.pollId);
      currentPresident =
          await PersonRepository.readById(currentMandate!.presidentId);
      presidentController.text = currentPresident != null ? currentPresident!.name : '';

      currentTreasurer =
          await PersonRepository.readById(currentMandate!.treasurerId);
      treasurerController.text = currentTreasurer != null ? currentTreasurer!.name : '';
    }

    personsList = await PersonRepository.readAll();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Definições',
      ),
      drawer: const MyAppDrawer(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ResponsiveLayout(
              mobileBody: MobileSettingsPage(
                currentPoll: currentPoll,
                currentPresident: currentPresident,
                currentTreasurer: currentTreasurer,
                currentMandate: currentMandate,
                onChangePresidentTreasurer: changePresidentTreasurer,
                onChangePersonLimit: changePersonLimit,
              ),
              tabletBody: TabletSettingsPage(
                currentPoll: currentPoll,
                currentPresident: currentPresident,
                currentTreasurer: currentTreasurer,
                currentMandate: currentMandate,
                onChangePresidentTreasurer: changePresidentTreasurer,
                onChangePersonLimit: changePersonLimit,
              ),
            ),
    );
  }

  Future<void> changePersonLimit() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alterar limite de membros'),
          content: TextField(
            controller: memberslimitController,
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar')),
            TextButton(
              onPressed: () async {
                setState(() => isLoading = true);
                int personLimit;
                personLimit = int.parse(memberslimitController.text);
                print('PersonLimit: $personLimit');
                final mandateUpdated = currentMandate!.copy(
                  personLimit: personLimit,
                );
                await MandateRepository.update(mandateUpdated);
                setState(() {
                  Navigator.pop(context);
                  refreshData();
                  isLoading = false;
                });
              },
              child: const Text('Guardar'),
            )
          ],
        );
      },
    );
  }

  Future<void> changePresidentTreasurer() async {
    await showDialog(
      context: context,
      builder: (context) {
        int idPresident = currentPresident!.id ?? 0;
        int idTreasurer = currentTreasurer!.id ?? 0;

        return AlertDialog(
          title: const Center(
            child: Text('Alterar Presidente e/ou Tesoureiro'),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0,),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: GestureDetector(
                    onTap: () async {
                      setState(() => isLoading = true);
                      await _showListPersonsDialog().then((value) {
                        if (value != null) {
                          setState(() {
                            final Person person = value as Person;
                            presidentController.text = person.name;
                            idPresident = person.id!;
                          });
                        }
                      });
                      setState(() => isLoading = false);
                    },
                    child: TextField(
                      enabled: false,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      autofocus: false,
                      controller: presidentController,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 1.0,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: 'Presidente',
                        labelStyle: const TextStyle(
                          color: kSecondaryColor,
                        ),
                        hintText: 'Selecione o presidente',
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        prefixIcon: const Icon(
                          FontAwesomeIcons.user,
                          color: kSecondaryColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: GestureDetector(
                    onTap: () async {
                      setState(() => isLoading = true);
                      await _showListPersonsDialog().then((value) {
                        if (value != null) {
                          setState(() {
                            final Person person = value as Person;
                            treasurerController.text = person.name;
                            idTreasurer = person.id!;
                          });
                        }
                      });
                      setState(() => isLoading = false);
                    },
                    child: TextField(
                      enabled: false,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      autofocus: false,
                      controller: treasurerController,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 1.0,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: 'Tesoureiro',
                        labelStyle: const TextStyle(
                          color: kSecondaryColor,
                        ),
                        hintText: 'Selecione o tesoureiro',
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        prefixIcon: const Icon(
                          FontAwesomeIcons.user,
                          color: kSecondaryColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                setState(() => isLoading = true);
                if (currentPresident != null && currentTreasurer != null) {
                  if (idPresident != currentPresident!.id || idTreasurer != currentTreasurer!.id) {
                    final mandateUpdated = currentMandate!.copy(
                      presidentId: idPresident,
                      treasurerId: idTreasurer
                    );
                    await MandateRepository.update(mandateUpdated);
                  }
                }
                setState(() => isLoading = false);
                Navigator.pop(context, true);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    ).then((value) {
      if (value as bool) {
        refreshData();
      }
    });
  }

  Future<dynamic> _showListPersonsDialog() async => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(left: 25, right: 25),
            title: const Center(
              child: Text('Membros'),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            content: SizedBox(
              height: personsList.isEmpty ? 150 : 350,
              width: 300,
              child: personsList.isEmpty
                  ? const Center(
                      child: Text(
                          'Não foram encontrados membros. Por favor, verifique se existem membros criados na aplicação.'),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10.0),
                          for (var i in personsList)
                            Column(
                              children: [
                                const Divider(
                                  height: 1.0,
                                  indent: 30.0,
                                  endIndent: 30.0,
                                  color: kPrimaryColor,
                                ),
                                ListTile(
                                  title: Center(child: Text(i.name)),
                                  onTap: () {
                                    final Person person;
                                    person = i;
                                    Navigator.pop(context, person);
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
            ),
            actions: [
              if (personsList.isEmpty)
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok'),
                ),
            ],
          );
        },
      );
}
