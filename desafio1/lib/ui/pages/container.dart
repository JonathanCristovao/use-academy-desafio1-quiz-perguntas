// ignore_for_file: deprecated_member_use

import 'package:desafio1/ui/pages/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyContainer extends StatefulWidget {
  const MyContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 2, width: 2),
          const Text(
            "Perguntas e Respostas",
            style: TextStyle(
                color: Colors.indigo,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          const Text("Responda 10 perguntas e veja sua pontuação no fim!"),
          Container(
            margin: const EdgeInsets.all(16),
            height: 50.0,
            width: double.infinity,
            child: RaisedButton(
              color: Colors.indigo,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const tela_perguntas()));
              },
              shape: const StadiumBorder(),
              child: const Text(
                'Start!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ],
      ),
      //  ),
    );
  }
}
