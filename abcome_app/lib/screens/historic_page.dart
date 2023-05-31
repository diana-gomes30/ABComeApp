import 'package:abcome_app/models/mandate.dart';
import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/repositories/mandate_repository.dart';
import 'package:abcome_app/repositories/poll_repository.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:flutter/material.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({Key? key}) : super(key: key);
  static const String id = '/historic_page';

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  bool isLoading = false;
  List<Mandate> mandateList = [];

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<void> getData() async {
    setState(() => isLoading = true);
    mandateList = await MandateRepository.readAll();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Histórico',
      ),
      drawer: const MyAppDrawer(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: ListView.builder(
                itemCount: mandateList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        'IdPoll: ${mandateList[index].id} || NumPersons: ${mandateList[index].personLimit} || President: ${mandateList[index].presidentId} || Treasurer: ${mandateList[index].treasurerId} || Active: ${mandateList[index].active}'),
                  );
                },
              ),
            ),
    );
  }
}
