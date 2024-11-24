import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/proivder.dart';

//
class CreateTask extends StatefulWidget {
  Map? iteamdata;
  CreateTask({super.key, this.iteamdata});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  bool isedit = false;
  TextEditingController Titlcon = TextEditingController();
  TextEditingController descraptioncon = TextEditingController();

  @override
  void initState() {
    final data = widget.iteamdata;
    if (widget.iteamdata != null) {
      isedit = true;
      Titlcon.text = data?['title'];
      descraptioncon.text = data!['description'];
    }

    super.initState();
    Provider.of<services>(context, listen: false).getdataprovider();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<services>(context, listen: false).getdataprovider();
    List mydata = Provider.of<services>(context).mydata;
    //List mydata = [Provider.of<services>(context).mydata];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 247, 239),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text(
            ' task title',
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: Titlcon,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32))),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(' Task Descraption'),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              maxLines: 5,
              controller: descraptioncon,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 192, 86, 213))),
                    onPressed: () {
                      isedit
                          ? Provider.of<services>(context, listen: false)
                              .updataprovider(context, Titlcon.text,
                                  descraptioncon.text, widget.iteamdata!['_id'])
                          : Provider.of<services>(context, listen: false)
                              .postdataprovider(
                                  context, Titlcon.text, descraptioncon.text);
                    },
                    child: Text(
                      isedit ? 'updata task' : 'create',
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Post = creat
/*
  Future<void> postdata() async {
    final listofmap = {
      "title": Titlcon.text,
      "description": descraptioncon.text,
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('uncreate'),
        backgroundColor: Colors.red[400],
      ));
    }
  }

   */

/* var url = Uri.https('api.nstack.in', 'v1/todos');
    var response = await http.post(url, body: {
      "title": "task title 2",
      "description": "hellow from notes app",
      "is_completed": 'false'
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
*/
//print(await http.read(Uri.https('https://api.nstack.in/v1/todos')));

// WidgetsBinding.instance.addPostFrameCallback((_) {

// put == updata
/*
  Future<void> updata() async {
    final id = widget.iteamdata!['_id'];
    final body = {
      "title": Titlcon.text,
      "description": descraptioncon.text,
      "is_completed": 'false'
    };
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(' error in updata'),
        backgroundColor: Colors.red[400],
      ));
    }
  }
  */
}
