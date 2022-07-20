import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class TestingAPI extends StatefulWidget {
  const TestingAPI({Key? key}) : super(key: key);

  @override
  State<TestingAPI> createState() => _TestingAPIState();
}

class _TestingAPIState extends State<TestingAPI> {
  Map<String, String> headers = {
    'content-type': 'application/json',
    'X-RapidAPI-Key': 'b63599e0ffmsh20ff7ae2fa30f40p1b55e7jsnadf9e3c63b0d',
    'X-RapidAPI-Host': 'quora-data-posts-questions-experts-search-results-data-provider.p.rapidapi.com'
  };
  Future<DataModel?> getApi() async {
    var response = await http.post(Uri.parse('https://quora-data-posts-questions-experts-search-results-data-provider.p.rapidapi.com/quora/start_job/'),
        headers: headers,
        body: jsonEncode(
          {"record": 1, "type": "post", "url": "https://www.quora.com/search?q=cats&type=post&time=year", "callback": "https://httpdump.io/example"},
        ));
    var data = response.body;
    print(data);

    if (response.statusCode == 200) {
      return dataModelFromJson(data);
    } else {
      print("not working");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: ElevatedButton(
            onPressed: () async {
              getApi();
            },
            child: Text('Press'),
          ),
        ),
      ),
    );
  }
}

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.record,
    required this.type,
    required this.url,
    required this.callback,
  });

  int? record;
  String type;
  String url;
  String callback;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        record: json["record"] ?? '',
        type: json["type"],
        url: json["url"],
        callback: json["callback"],
      );

  Map<String, dynamic> toJson() => {
        "record": record,
        "type": type,
        "url": url,
        "callback": callback,
      };
}
