import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Create_Task.dart';
import 'package:todo_app/Homepage.dart';
import 'package:todo_app/proivder.dart';

int colorhex = 0xffa8bacf;
Color minColor = Color(colorhex);
Color newColor = Color(0xfffca8ba); // new color
bool isOriginalColor = true;

class SeeAll extends StatefulWidget {
  SeeAll({super.key});

  @override
  State<SeeAll> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SeeAll> {
  // List mydata = [];
  @override
  /* void initState() {
    Provider.of<services>(context, listen: false).getdataprovider();
  }*/

  Widget build(BuildContext context) {
    List mydata = Provider.of<services>(context).mydata;
    Provider.of<services>(context, listen: false).getdataprovider();
    return Scaffold(
      backgroundColor: const Color(0xff362f2e),
      floatingActionButton: FloatingActionButton(
        backgroundColor: minColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateTask()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                    (Route) => false);
              },
              icon: Icon(Icons.logout))
        ],
        backgroundColor: minColor,
        leading: IconButton(
          onPressed: () {
            setState(() {
              if (isOriginalColor) {
                minColor = newColor;
              } else {
                minColor = Color(colorhex);
              }
              isOriginalColor = !isOriginalColor;
            });
          },
          icon: const Icon(Icons.color_lens),
        ),
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              'All Tasks',
            ),
            Text('(my notes)')
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  DateFormat.yMMMMEEEEd().add_jms().format(
                        DateTime.now(),
                      ),
                  style: TextStyle(color: minColor),
                ),
              ],
            ),
            Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Opacity(
                  opacity: 0.78,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: minColor),
                      onPressed: () {
                        setState(() {
                          Provider.of<services>(context, listen: false)
                              .getdataprovider();
                        });
                        // getdata();
                        //print(mydata);
                      },
                      child: const Icon(Icons.refresh_sharp)),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  'Tody task',
                  style: TextStyle(color: minColor),
                ),
              ],
            ),
            const Row(
              children: [
                Spacer(
                  flex: 2,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: mydata.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = mydata.reversed.toList()[index];
                  return Container(
                    margin: const EdgeInsets.all(16),
                    color: minColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(
                              top: 30,
                            )),
                            const Spacer(
                              flex: 1,
                            ),
                            Text(
                              data['title'],
                              style: const TextStyle(fontSize: 20),
                            ),
                            const Spacer(
                              flex: 20,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            Text(
                              data['description'],
                              style: TextStyle(fontSize: 20),
                            ),
                            const Spacer(
                              flex: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            Text(
                              DateFormat.yMMMMEEEEd().add_jms().format(
                                    DateTime.now(),
                                  ),
                              style: const TextStyle(fontSize: 15),
                            ),
                            const Spacer(
                              flex: 25,
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: const Text(
                                              'are yo sure to delet'),
                                          actions: [
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: minColor,
                                                ),
                                                onPressed: () {
                                                  Provider.of<services>(context,
                                                          listen: false)
                                                      .deletebyidprovider(
                                                          data['_id'], context);
                                                  Navigator.pop(context);

                                                  /// Navigator.pop(context);
                                                },
                                                child: const Text('Yes')),
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: minColor,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('No'))
                                          ],
                                          icon: const Icon(Icons.warning_amber,
                                              color: Colors.red),
                                          title: const Text('Alert'),
                                        );
                                      });
                                },
                                icon: const Icon(Icons.delete)),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateTask(
                                      iteamdata: data,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Checkbox(
                                value: data['is_completed'],
                                onChanged: (val) {}),
                            const Padding(padding: EdgeInsets.only(bottom: 25))
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// get

  /*
  Future<void> getdata() async {
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

      setState(() {
        mydata = filterdata;
      });
    }
  }
  */

  /* void checkbo(
      {bool check = false,
      String idi = '',
      String title = '',
      String des = ''}) async {
    final id = idi;
    //mydata[index]['id'];
    final body = {
      "title": "title",
      "description": "des",
      "is_completed": check,
    };
    var url = Uri.parse('https://api.nstack.in/v1/todos/$idi');
    final response = await http.put(url,
        headers: {
          'accept': 'application/json',
          'Content-Type': ' application/json'
        },
        body: jsonEncode(body));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
*/
  /*deletebyid(String _id) async {
    //final id = '66b4b12756c81cef89dbc5c1';
    var url = Uri.parse('https://api.nstack.in/v1/todos/$_id');
    await http.delete(url);
  }*/
}



 
/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:todo_app/Create_Task.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  Map? iteamdata;  return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateTask()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: minColor,
        leading: IconButton(
          onPressed: () {
            setState(() {
              if (isOriginalColor) {
                minColor = newColor;
              } else {
                minColor = Color(colorhex);
              }
              isOriginalColor = !isOriginalColor;
            });
          },
          icon: Icon(Icons.color_lens),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Welcome Back',
            ),
            Text('Ahmed Hamid')
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  DateFormat.yMMMMEEEEd().add_jms().format(
                        DateTime.now(),
                      ),
                  style: TextStyle(color: minColor),
                ),
              ],
            ),
            Row(
              children: [
                Spacer(
                  flex: 2,
                ),
                Opacity(
                  opacity: 0.78,
                  child: ElevatedButton(
                      onPressed: () {
                        getdata();
                        //print(mydata);
                      },
                      child: Icon(Icons.refresh_sharp)),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text('Tody task'),
              ],
            ),
            Row(
              children: [
                Spacer(
                  flex: 2,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text('See all'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: mydata.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = mydata.reversed.toList()[index];
                  return Container(
                    margin: EdgeInsets.all(16),
                    color: minColor,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                              top: 30,
                            )),
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              data['title'],
                              style: TextStyle(fontSize: 20),
                            ),
                            Spacer(
                              flex: 20,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              data['description'],
                              style: TextStyle(fontSize: 20),
                            ),
                            Spacer(
                              flex: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              DateFormat.yMMMMEEEEd().add_jms().format(
                                    DateTime.now(),
                                  ),
                              style: TextStyle(fontSize: 15),
                            ),
                            Spacer(
                              flex: 25,
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text('are yo sure to delet'),
                                          actions: [
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: minColor,
                                                ),
                                                onPressed: () {
                                                  deletebyid(data['_id']);

                                                  Navigator.pop(context);

                                                  /// Navigator.pop(context);
                                                },
                                                child: Text('Yes')),
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: minColor,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('No'))
                                          ],
                                          icon: Icon(Icons.warning_amber,
                                              color: Colors.red),
                                          title: Text('Alert'),
                                        );
                                      });
                                },
                                icon: Icon(Icons.delete)),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateTask(
                                      iteamdata: data,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Checkbox(
                                value: data['is_completed'],
                                onChanged: (val) {}),
                            Padding(padding: EdgeInsets.only(bottom: 25))
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// get
  Future<void> getdata() async {
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

      setState(() {
        mydata = filterdata;
      });
    }
  }

  /* void checkbo(
      {bool check = false,
      String idi = '',
      String title = '',
      String des = ''}) async {
    final id = idi;
    //mydata[index]['id'];
    final body = {
      "title": "title",
      "description": "des",
      "is_completed": check,
    };
    var url = Uri.parse('https://api.nstack.in/v1/todos/$idi');
    final response = await http.put(url,
        headers: {
          'accept': 'application/json',
          'Content-Type': ' application/json'
        },
        body: jsonEncode(body));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
*/
  deletebyid(String _id) async {
    //final id = '66b4b12756c81cef89dbc5c1';
    var url = Uri.parse('https://api.nstack.in/v1/todos/$_id');
    await http.delete(url);
  }
}


*/


  
