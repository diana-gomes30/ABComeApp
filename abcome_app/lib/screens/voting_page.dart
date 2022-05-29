import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Selecione os membros que irão votar',
                        style: TextStyle(
                          fontSize: 25,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: personsList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height*0.5),
                        ),
                        itemBuilder: (_, i) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                value = !value;
                              });
                            },
                            child: Builder(builder: (context) {
                              return Container(
                                height: 100,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                    //padding: const EdgeInsets.all(10.0),
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
                                            value: value,
                                            /*secondary: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: personsList[i].image == ''
                                                    ? const Image(
                                                  image: AssetImage(kLogoImagePath),
                                                  fit: BoxFit.cover,
                                                )
                                                    : Utils.imageFromBase64String(
                                                  personsList[i].image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),*/
                                            onChanged: (newValue) {
                                              setState(() {
                                                value = newValue!;
                                              });
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                            /*Card(
                              color: Colors.green,
                              margin: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: ClipOval(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: personsList[i].image == ''
                                            ? const Image(
                                                image: AssetImage(kLogoImagePath),
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              )
                                            : Utils.imageFromBase64String(
                                                personsList[i].image,
                                                width: 100.0,
                                                height: 100.0,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CheckboxListTile(
                                        value: value,
                                        onChanged: (newValue) {
                                          setState(() => value = newValue!);
                                        },
                                      ),
                                      Center(
                                        child: SizedBox(
                                          height: 100,
                                          child: Text(
                                            personsList[i].name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),*/
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
