import 'package:abcome_app/database/abcome_database.dart';
import 'package:abcome_app/responsive/responsive_layout.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    //deleteDB();
    //createDB();
  }

  void createDB() async {
    await ABComeDatabase.instance.database;
    //await MandateRepository.insertDefault();
  }

  void deleteDB() async {
    await ABComeDatabase.instance.deleteDatabase();
  }

  @override
  Widget build(BuildContext context) {
    bool useLogo = false;

    return Scaffold(
      appBar: const MyAppBar(title: 'A.B.Come'),
      drawer: const MyAppDrawer(),
      body: SafeArea(
        child: ResponsiveLayout(
          mobileBody: Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(kBackgroundMobile),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          tabletBody: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(kBackgroundTablet),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Visibility(
                visible: useLogo,
                child: Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    kLogoImagePath,
                    width: 250,
                    height: 250,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
