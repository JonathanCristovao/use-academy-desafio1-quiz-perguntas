import 'package:desafio1/ui/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class TelaResultado extends StatefulWidget {
  int score;
  TelaResultado(this.score, {Key? key}) : super(key: key);

  @override
  TelaResultadoState createState() => TelaResultadoState();
}

class TelaResultadoState extends State<TelaResultado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perguntas e respostas'),
        centerTitle: true,
      ),
      backgroundColor: Colors.indigo[100],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 2, width: 2),
                    const Text(
                      "Perguntas e Respostas",
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15, width: 15),
                    const Text("Sua pontuação foi de"),
                    const SizedBox(height: 15, width: 15),
                    Text(
                      "${widget.score}/10 Acertos",
                      style: const TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Homepage(),
                            ));
                      },
                      child: const Text(
                        "Tentar novamente",
                        style: TextStyle(
                          color: Colors.indigo,
                          decoration: TextDecoration.underline,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
