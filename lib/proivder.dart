import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class services with ChangeNotifier {
  List mydata = [];
  getdataprovider() async {
    var Url = Uri.parse('https://api.nstack.in/v1/todos');

    var response = await http.get(Url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jeson = jsonDecode(response.body);

      mydata = jeson["items"];
      final filterdata = mydata
          .where((element) => (DateFormat.yMMMEd()
                  .format(DateTime.parse(element["created_at"])) ==
              DateFormat.yMMMEd().format(DateTime.now())))
          .toList();

      mydata = filterdata;
      notifyListeners();
    }
  }
  // Post = creat

  Future<void> postdataprovider(
      BuildContext context, String title, String des) async {
    final listofmap = {
      "title": title,
      "description": des,
      "is_completed": 'false'
    };
    var url = Uri.parse('https://api.nstack.in/v1/todos?page=1&limit=10');

    var response = await http.post(url,
        headers: {
          'accept': 'application/json',
          'Content-Type': ' application/json'
        },
        body: jsonEncode(listofmap));
    // print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('create'),
        backgroundColor: Colors.green,
      ));

      //getdataprovider();
      //Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('uncreate'),
        backgroundColor: Colors.red[400],
      ));
    }

    Navigator.pop(context);
  }

//

  Future<void> updataprovider(
      BuildContext context, String title, String des, String id1) async {
    //final id = widget.iteamdata!['_id'];
    final id = id1;
    final body = {"title": title, "description": des, "is_completed": 'false'};
    var url = Uri.parse('https://api.nstack.in/v1/todos/$id');
    final response = await http.put(url,
        headers: {
          'accept': 'application/json',
          'Content-Type': ' application/json'
        },
        body: jsonEncode(body));
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('updata successful'),
        backgroundColor: Colors.green,
      ));

      getdataprovider();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(' error in updata'),
        backgroundColor: Colors.red[400],
      ));
    }
  }

  deletebyidprovider(String _id, BuildContext context) async {
    //final id = '66b4b12756c81cef89dbc5c1';
    var url = Uri.parse('https://api.nstack.in/v1/todos/$_id');
    await http.delete(url);
    getdataprovider();
    Navigator.pop(context);
  }
}
