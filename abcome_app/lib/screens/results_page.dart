import 'package:abcome_app/models/vote.dart';
import 'package:abcome_app/repositories/vote_repository.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);
  static const String id = '/results_page';

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  bool isLoading = false;
  List<Vote> voteList = [];

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<void> getData() async {
    setState(() => isLoading = true);
    voteList = await VoteRepository.readAll();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Resultados',
      ),
      drawer: const MyAppDrawer(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: ListView.builder(
                itemCount: voteList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        'IdVote: ${voteList[index].id} || PersonId: ${voteList[index].personId} || PollId: ${voteList[index].pollId} || President: ${voteList[index].presidentId} || Treasurer: ${voteList[index].treasurerId}'),
                  );
                },
              ),
            ),
    );
  }
}
