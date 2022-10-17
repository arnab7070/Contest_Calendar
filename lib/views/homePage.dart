// ignore: duplicate_ignore
// ignore_for_file: file_names, duplicate_ignore

import 'package:contest/services/apicall.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../models/contest.dart';
import '../services/apicall.dart';

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
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Start Time: ${contest[index].startTime}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purpleAccent,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'End Time: ${contest[index].endTime}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purpleAccent,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => launchUrlString(
                              contest[index].url,
                              mode: LaunchMode.externalApplication,
                            ),
                            child: const Text(
                              'Details',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
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
