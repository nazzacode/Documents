import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Journal> fetchJournal() async {
  final response = await http.get('http://10.0.2.2:8080');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    return Journal.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    throw Exception('Failed to load album');
  }
}

class Journal {
  List<JournalEntry> journal;

  Journal({this.journal});

  factory Journal.fromJson(List<dynamic> json) {
    return Journal(journal: json.map((i) => JournalEntry.fromJson(i)).toList());
  }
}

class JournalEntry {
  final String date;
  String body;
  String sentiment;
  String topic;
  // final String userID;   // unused map

  JournalEntry({this.body, this.date, this.sentiment, this.topic});

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      body: json['body'],
      date: json['date'],
      sentiment: json['sentiment'],
      topic: json['topic'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Journal> futureJournal;

  @override
  void initState() {
    super.initState();
    futureJournal = fetchJournal();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Journal>(
            future: futureJournal,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.journal[1].body);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
