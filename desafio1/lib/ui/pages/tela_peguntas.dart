import 'package:desafio1/ui/pages/tela_resultado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class tela_perguntas extends StatefulWidget {
  const tela_perguntas({Key? key}) : super(key: key);

  @override
  _tela_perguntasState createState() => _tela_perguntasState();
}

class _tela_perguntasState extends State<tela_perguntas> {
  int question_pos = 0;
  int score = 0;
  int cont = 0;
  bool btnPressed = false;
  bool trocarCor = false;
  bool _flag = true;
  PageController? _controller;
  String go_proximaPergunta = "Proxima pergunta";
  bool answered = false;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perguntas e Respostas'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.indigo[50],
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: PageView.builder(
            controller: _controller!,
            onPageChanged: (page) {
              setState(() {
                answered = false;
              });
            },
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 2.0),
                  SizedBox(
                    width: double.infinity,
                    height: 100.0,
                    child: Text(
                      "${questions[index].question}",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      //textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Respostas",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  for (int i = 0; i < questions[index].answers!.length; i++)
                    Container(
                      width: double.infinity,
                      height: 80.0,
                      margin:
                          EdgeInsets.only(bottom: 5.0, left: 12.0, right: 12.0),
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        fillColor: MudarCor(btnPressed, index, i, trocarCor),
                        onPressed: !answered
                            ? () {
                                print('cor selecionada');
                                trocarCor = false;
                                if (questions[index]
                                    .answers!
                                    .values
                                    .toList()[i]) {
                                  score++; // se clicou na resposta certa incrementa a pontuacao
                                }
                                setState(() {
                                  //btnPressed = true;
                                  answered = true;
                                });
                              }
                            : null,
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(5.0)),
                              margin: EdgeInsets.only(
                                  bottom: 5.0, left: 12.0, right: 12.0),
                            ),
                            const SizedBox(height: 50.0),
                            Text(
                              questions[index].answers!.keys.toList()[i],
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 40.0),
                  Container(
                      margin: EdgeInsets.all(16),
                      height: 50.0,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          if (cont == 0) {
                            setState(() => _flag = !_flag);
                            btnPressed = true;
                            trocarCor = true;
                            print('clicou uma vez');
                            cont++;
                          } else {
                            if (_controller!.page?.toInt() ==
                                questions.length - 1) {
                              //ir para ultima tela
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TelaResultado(score)));
                              // print('ir para ultima tela');
                            } else {
                              _controller!.nextPage(
                                  duration: Duration(milliseconds: 50),
                                  curve: Curves.easeInExpo);

                              setState(() {
                                btnPressed = false;
                                trocarCor = false;
                                _flag = true;
                                cont = 0;
                              });
                            }
                          }
                        },
                        shape: StadiumBorder(),
                        color: _flag ? Colors.grey : Colors.indigo,
                        padding: EdgeInsets.all(18.0),
                        elevation: 0.0,
                        child: Text(_flag ? 'Responder' : go_proximaPergunta),
                        textColor: Colors.white,
                      )),
                ],
              );
            },
            itemCount: questions.length,
          )),
    );
  }
}

Color? MudarCor(bool btnPressed, int index, int i, bool trocaCor) {
  return btnPressed
      ? questions[index].answers!.values.toList()[i]
          ? Colors.green
          : Colors.red
      : Colors.indigo[50];
}

class QuestionModel {
  String? question;
  Map<String, bool>? answers;
  QuestionModel(this.question, this.answers);
}

List<QuestionModel> questions = [
  QuestionModel(
    "Quanto é 10+4 ?",
    {
      "1": false,
      "3": false,
      "14": true,
      "57": false,
    },
  ),
  QuestionModel("Qual dos meios de transporte abaixo é um automovel ?", {
    "carro": true,
    "bicicleta": false,
    "moto": false,
    "aviao": false,
  }),
  QuestionModel("Qual animal é uma ave ?", {
    "pardal": true,
    "baleia": false,
    "gato": false,
    "cachorro": false,
  }),
];
