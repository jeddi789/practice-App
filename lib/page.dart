import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PopulationData extends StatefulWidget {
  const PopulationData({Key? key}) : super(key: key);

  @override
  State<PopulationData> createState() => _PopulationDataState();
}

class _PopulationDataState extends State<PopulationData> {
  var responseBody;
  bool loading = true;
  List jokes = [];

  @override
  getjokes() async {
    setState(() {
      loading = true;
    });
    print('api calling...............');
    var api =
        "https://official-joke-api.appspot.com/random_joke";
    var response = await http.get(
      Uri.parse(api),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        responseBody = jsonDecode(response.body);
        debugPrint('$responseBody');

      });

      debugPrint('setup:  ${responseBody['setup']}');

    } else {
      print("Server error please try again later");
    }
    setState(() {
      loading = false;
    });
    print('Api ok....');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('jokes API'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Column(
          children: [
            ElevatedButton(
              child: Text('New Jokes'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () {
                getjokes();

              },
            ),
            responseBody!=null ? Text(responseBody['setup']):Container()
          ],
        ),
      ),
    );
  }
}