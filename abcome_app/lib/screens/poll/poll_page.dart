import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/models/vote.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/repositories/poll_repository.dart';
import 'package:abcome_app/repositories/vote_repository.dart';
import 'package:abcome_app/screens/poll/vote_page.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
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

  bool value = true;
  List<Person> personsList = [];
  int numPersons = 0;
  late Poll currentPoll;

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
                                personsList[i].isVoting = value ? 1 : 0;
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
                            int num = 0;
                            for (Person p in personsList) {
                              if (p.isVoting == 1) {
                                num++;
                              }
                            }
                            if (num > 0) {
                              setState(() => isLoading = true);
                              bool updated = await updatePersons();
                              setState(() => isLoading = false);
                              if (updated) {
                                await insertUpdatePoll();
                              }
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
                              );
                            }
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
      Navigator.pushNamed(context, VotePage.id);
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
                    await VoteRepository.deleteByPoll(pollExists.id ?? 0);
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
        ).then((value) => Navigator.pushNamed(context, VotePage.id));
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

  Future<bool> insertVotes() async {
    try {
      for (Person person in personsList) {
        if (person.id != null && currentPoll.id != null) {
          Vote? voteExists = await VoteRepository.readByPersonPoll(
            person.id!,
            currentPoll.id!,
          );
          if (voteExists == null) {
            final vote = Vote(
              personId: person.id!,
              pollId: currentPoll.id!,
              presidentId: 0,
              treasurerId: 0,
            );
            await VoteRepository.insert(vote);
          }
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
