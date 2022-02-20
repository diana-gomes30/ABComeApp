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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'A.B.Come'),
      drawer: const MyAppDrawer(),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(kBackgroundImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              kLogoImagePath,
              width: 250,
              height: 250,
            ),
          ),
        ],
      ),
    );
  }
}
