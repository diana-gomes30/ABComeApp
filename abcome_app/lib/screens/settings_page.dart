import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const String id = '/settings_page';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Definições',
      ),
      drawer: const MyAppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                          padding: const EdgeInsets.only(bottom: 20, top: 20),
                          child: const Text(
                            'Nome Presidente',
                            style: TextStyle(
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
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                          padding: const EdgeInsets.only(bottom: 20, top: 5),
                          child: const Text(
                            'Nome Tesoureiro',
                            style: TextStyle(
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
                indent: 50,
                endIndent: 50,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 50),
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
                          padding: EdgeInsets.only(left: 50),
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
                          padding: EdgeInsets.only(left: 50),
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
                          padding: EdgeInsets.only(right: 70),
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Max: 20',
                              style: TextStyle(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String imagePath) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Utils.imageFromBase64String(
          imagePath,
          width: 200.0,
          height: 200.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
