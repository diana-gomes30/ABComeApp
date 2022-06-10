import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VotingPage extends StatefulWidget {
  const VotingPage({Key? key}) : super(key: key);
  static const String id = '/voting_page';

  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  bool isLoading = false;

  bool value = true;
  List<Person> personsList = [];

  @override
  void initState() {
    super.initState();

    getPersons();
  }

  Future<void> getPersons() async {
    setState(() => isLoading = true);

    personsList = await PersonRepository.readAll();

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
              child: Column(
                children: [
                  const Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Selecione os membros que irão votar',
                          style: TextStyle(
                            fontSize: 25,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    fit: FlexFit.loose,
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: personsList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height * 0.5),
                        ),
                        itemBuilder: (_, i) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                value = !value;
                              });
                            },
                            child: Builder(
                              builder: (context) {
                                return buildPersonCard(i);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            await updatePersons();

                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: const Text(
                            'Iniciar Votação',
                            style: TextStyle(
                              color: kWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  SizedBox buildPersonCard(int i) {
    return SizedBox(
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CheckboxListTile(
              secondary: personsList[i].image == ''
                  ? const Image(
                      image: AssetImage(kLogoImagePath),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : Utils.imageFromBase64String(
                      personsList[i].image,
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
              activeColor: kPrimaryColor,
              dense: true,
              //font change
              title: Text(
                personsList[i].name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              value: personsList[i].isVoting == 0 ? false : true,
              onChanged: (newValue) {
                setState(
                  () {
                    personsList[i].isVoting = newValue! ? 1 : 0;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }


  Future updatePersons() async {
    for(Person person in personsList) {
      await PersonRepository.update(person);
    }
    //Navigator.pop(context);
  }
}
