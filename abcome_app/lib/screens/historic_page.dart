import 'package:abcome_app/models/poll.dart';
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
  List<Poll> pollList = [];

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<void> getData() async {
    setState(() => isLoading = true);
    pollList = await PollRepository.readAll();
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
                itemCount: pollList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        'IdPoll: ${pollList[index].id} || NumPersons: ${pollList[index].numPersons} || Year: ${pollList[index].year} || President: ${pollList[index].presidentId} || Treasurer: ${pollList[index].treasurerId} || Active: ${pollList[index].active} || Cancel: ${pollList[index].cancelled}'),
                  );
                },
              ),
            ),
    );
  }
}
