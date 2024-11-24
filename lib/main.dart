import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/proivder.dart';

import 'Homepage.dart';

void main() {
  runApp(ToDo_app());
}

class ToDo_app extends StatelessWidget {
  const ToDo_app({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => services(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Homepage(),
        ));
  }
}
