import 'package:abcome_app/models/mandate.dart';
import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/repositories/mandate_repository.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/repositories/poll_repository.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:abcome_app/widgets/custom_divider.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const String id = '/settings_page';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLoading = false;
  late TextEditingController memberslimitController;

  Mandate? currentMandate;
  Poll? currentPoll;
  Person? currentPresident;
  Person? currentTreasurer;

  @override
  void initState() {
    super.initState();

    memberslimitController = TextEditingController(text: '');
    refreshData();
  }

  Future<void> refreshData() async {
    setState(() => isLoading = true);

    currentMandate = await MandateRepository.readActive();

    if (currentMandate != null) {
      currentPoll = await PollRepository.readById(currentMandate!.pollId);
      currentPresident =
          await PersonRepository.readById(currentMandate!.presidentId);
      currentTreasurer =
          await PersonRepository.readById(currentMandate!.treasurerId);
    }

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    memberslimitController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Definições',
      ),
      drawer: const MyAppDrawer(),
      body: isLoading
          ? const LoaderOverlay(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        currentPoll != null
                            ? 'Ano de Mandato: ${currentPoll!.year}/${(currentPoll!.year) + 1}'
                            : 'Ano de Mandato: 20xx/20xx',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: const Text(
                                  'Presidente',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              buildImage(kLogoImagePath),
                              Container(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 20),
                                child: Text(
                                  currentPresident != null
                                      ? currentPresident!.name
                                      : 'Presidente não definido',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: const Text(
                                  'Tesoureiro',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              buildImage(kLogoImagePath),
                              Container(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 5),
                                child: Text(
                                  currentTreasurer != null
                                      ? currentTreasurer!.name
                                      : 'Tesoureiro não definido',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const CustomDivider(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 50),
                              width: MediaQuery.of(context).size.width * 0.70,
                              child: TextButton(
                                onPressed: () {},
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.arrow_right_sharp,
                                      size: 40,
                                      color: kPrimaryColor,
                                    ),
                                    title: Text(
                                      'Alterar o Presidente',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 50),
                              width: MediaQuery.of(context).size.width * 0.70,
                              child: TextButton(
                                onPressed: () {},
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.arrow_right_sharp,
                                      size: 40,
                                      color: kPrimaryColor,
                                    ),
                                    title: Text(
                                      'Alterar o Tesoureiro',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 50),
                              width: MediaQuery.of(context).size.width * 0.70,
                              child: TextButton(
                                onPressed: () {
                                  buildLimitPersonDialog(context);
                                },
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.arrow_right_sharp,
                                      size: 40,
                                      color: kPrimaryColor,
                                    ),
                                    title: Text(
                                      'Alterar o limite máximo de membros do grupo',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 70),
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  currentMandate != null
                                      ? 'Max: ${currentMandate!.personLimit}'
                                      : 'Max: 2',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  buildLimitPersonDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Alterar o limite de membros'),
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
                  int personLimit;
                  personLimit = int.parse(memberslimitController.text);
                  print('PersonLimit: $personLimit');
                  await updateMandate(personLimit: personLimit);
                  setState(() {
                    memberslimitController = TextEditingController(text: '');
                    Navigator.pop(context);
                    refreshData();
                  });
                },
                child: const Text('Guardar'),
              )
            ],
          );
        });
  }

  Widget buildImage(String imagePath) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Utils.imageFromBase64String(
          imagePath,
          width: 175.0,
          height: 175.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> updateMandate(
      {int? presidentId,
      int? treasurerId,
      int? yearIni,
      int? yearFim,
      int? personLimit}) async {
    /*final mandateUpdated = Mandate(
      id: currentMandate.id,
      president: presidentId ?? currentMandate.president,
      treasurer: treasurerId ?? currentMandate.treasurer,
      yearIni: yearIni ?? currentMandate.yearIni,
      yearFim: yearFim ?? currentMandate.yearFim,
      personLimit: personLimit ?? currentMandate.personLimit,
    ).copy();

    print('ID --> ${mandateUpdated.id}');
    await MandateRepository.update(mandateUpdated);*/
  }
}
