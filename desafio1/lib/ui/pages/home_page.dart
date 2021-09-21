import 'package:desafio1/ui/pages/container.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late int counter = 0;
  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Perguntas e respostas'),
            centerTitle: true,
          ),
          backgroundColor: Colors.indigo[100],
          body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  MyContainer(),
                ]),
          )),
    );
  }
}
