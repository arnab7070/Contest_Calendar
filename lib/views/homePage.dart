// ignore: duplicate_ignore
// ignore_for_file: file_names, duplicate_ignore

import 'package:contest/services/apicall.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../models/contest.dart';
import '../services/apicall.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Contest> contest = [];
  var isLoaded = false;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    contest = (await Remote().getPosts())!;
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Upcoming Contests'),
        elevation: 5,
        backgroundColor: Colors.redAccent,
        leading: const Icon(
          Icons.code,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
            itemCount: contest.length,
            itemBuilder: (context, index) {
              String startDate = contest[index].startTime;
              startDate = startDate.replaceFirst(' ', 'T');
              String endDate = contest[index].endTime;
              endDate = endDate.replaceFirst(' ', 'T');
              double time = double.parse(contest[index].duration);
              String finalTime;
              if((time / (3600*24))>30.0){
                finalTime = "∞";
              }
              else{
                if((time / 3600)<24.0){
                  finalTime = "${(time / 3600).toStringAsFixed(1)} Hours";
                }
                else{
                  finalTime = "${(time / (3600*24)).toStringAsFixed(0)} Days";
                }
              }
              return Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child:
                              Image.asset(imageSelector(contest[index].site)),
                        ),
                        title: Text(
                          contest[index].site,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        subtitle: Text(
                          contest[index].name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'Start Date: ${DateFormat.MMMMEEEEd().format(DateTime.parse(startDate.substring(0, 19)))}'
                                '\nStart Time: ${DateFormat.jm().format(DateTime.parse(startDate.substring(0, 19)))}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'End Date: ${DateFormat.MMMMEEEEd().format(DateTime.parse(endDate.substring(0, 19)))}'
                                '\nEnd Time: ${DateFormat.jm().format(DateTime.parse(endDate.substring(0, 19)))}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: ButtonBar(
                          alignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RaisedButton(
                              onPressed: () => launchUrlString(
                                contest[index].url,
                                mode: LaunchMode.externalApplication,
                              ), 
                              color: Colors.redAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                'Visit Website',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Duration: $finalTime',
                                style: const TextStyle(
                                  color: Colors.pink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Image.asset('assets/POTD.png'),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

String imageSelector(String str) {
  String ans = 'assets/POTD.png';
  if (str == 'HackerEarth') {
    ans = 'assets/hackerEarth.png';
  } else if (str == 'AtCoder') {
    ans = 'assets/atcoder.png';
  } else if (str == 'LeetCode') {
    ans = 'assets/leetcode.png';
  } else if (str == 'CodeForces') {
    ans = 'assets/codeforces.png';
  } else if (str == 'CodeChef') {
    ans = 'assets/codechef.jpg';
  } else if (str == 'Kick Start') {
    ans = 'assets/google.png';
  } else if (str == 'TopCoder') {
    ans = 'assets/topcoder.jpg';
  } else if (str == 'HackerRank') {
    ans = 'assets/hackerrank.png';
  }
  return ans;
}
