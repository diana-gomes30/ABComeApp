import 'package:abcome_app/models/mandate.dart';
import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/repositories/mandate_repository.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
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

  late Mandate currentMandate;
  Person? currentPresident;
  Person? currentTreasurer;

  @override
  void initState() {
    super.initState();

    memberslimitController = TextEditingController(text: '');
    refreshData();
  }

  /*int getCurrentYear() {
    int currentYear = DateTime.now().year;
    print('Ano: $currentYear');

    return currentYear;
  }*/

  // Função que vai buscar o últímo mandato. Se não existir, então vai buscar o mandato por defeito e de seguida vai buscar o presidente e o tesoureiro
  Future<void> refreshData() async {
    setState(() => isLoading = true);

    final mandate = await MandateRepository.readLast();
    if (mandate == null) {
      currentMandate = await MandateRepository.readActive();
    } else {
      currentMandate = mandate;
    }

    /*currentPresident =
        await PersonRepository.readById(currentMandate.president);
    currentTreasurer =
        await PersonRepository.readById(currentMandate.treasurer);*/

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
                      child: const Text('Ano de Mandato: 20xx/20xx',
                        //'Ano de Mandato: ${currentMandate.yearIni} / ${currentMandate.yearFim}',
                        style: TextStyle(
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
                                  currentPresident != null
                                      ? currentPresident!.name
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
                    const Divider(
                      color: kPrimaryColor,
                      height: 5,
                      indent: 50,
                      endIndent: 50,
                    ),
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
                                      'Alterar Anos de Mandato',
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
                                  'Max: ${currentMandate.personLimit}',
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
