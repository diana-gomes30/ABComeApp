import 'package:abcome_app/components/app_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = '/homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A.B.Come'),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: IconButton(
          icon: Image.asset('images/logotipo.jpg'),
          iconSize: 200,
          onPressed: () {  },
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}