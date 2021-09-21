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
  int soma = 0;
  bool _flag = true;
  PageController? _controller;
  String go_proximaPergunta = "Proxima pergunta";
  bool answered = false;
  Icon icone = const Icon(
    Icons.close,
    size: 16,
    color: Colors.transparent,
  );

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  Color borderColor = Colors.indigo;
  Color newColor = Colors.indigo;

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
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
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
                      height: 90.0,
                      margin:
                          EdgeInsets.only(bottom: 5.0, left: 12.0, right: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: CorTexto(btnPressed, index, i, answered,
                                question_pos, soma),
                            width: 1.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        fillColor: MudarCor(
                            btnPressed,
                            index,
                            i,
                            answered,
                            question_pos,
                            soma), // alterar a cor das caixas de respostas
                        onPressed: !answered
                            ? () {
                                trocarCor = true;
                                question_pos = i;

                                soma++;
                                if (questions[index]
                                        .answers!
                                        .values
                                        .toList()[i] &&
                                    soma == 1) {
                                  score++; // se clicou na resposta certa incrementa a pontuacao
                                }
                                setState(() {
                                  true;
                                });
                              }
                            : null,

                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              height: 25,
                              width: 25,
                              margin: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color: MudarCor(btnPressed, index, i,
                                      answered, question_pos, soma),
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: Colors.indigo,
                                    width: 2,
                                  )),
                              child: Icon(
                                btnPressed
                                    ? questions[index]
                                            .answers!
                                            .values
                                            .toList()[i]
                                        ? Icons.check_sharp
                                        : Icons.close
                                    : Icons.check_sharp,
                                size: 20,
                                color: IconCor(btnPressed, index, i, answered,
                                    question_pos, soma),
                              ), // variavel com o icone
                            ),
                            Text(
                              questions[index].answers!.keys.toList()[i],
                              style: TextStyle(
                                  color: CorTexto(btnPressed, index, i,
                                      answered, question_pos, soma),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 2.0),
                  Container(
                      margin: const EdgeInsets.all(16),
                      height: 60.0,
                      width: double.infinity,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        onPressed: () {
                          if (cont == 0) {
                            setState(() => _flag = !_flag);
                            btnPressed = true;
                            //trocarCor = true;
                            soma == 1;
                            icone = Icon(answered ? Icons.close : Icons.done,
                                size: 16);
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
                                  duration: const Duration(milliseconds: 50),
                                  curve: Curves.easeInExpo);

                              setState(() {
                                soma = 0;
                                icone = const Icon(Icons.close,
                                    size: 16, color: Colors.transparent);

                                btnPressed = false;
                                trocarCor = false;
                                _flag = true;
                                cont = 0;
                              });
                            }
                          }
                        },
                        shape: const StadiumBorder(),
                        color: _flag ? Colors.grey : Colors.indigo,
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

// ignore: non_constant_identifier_names
Color? MudarCor(
    bool btnPressed, int index, int i, bool answer, int questionPos, int soma) {
  if (btnPressed) {
    if (questions[index].answers!.values.toList()[i]) {
      return Colors.green[100];
    } else if (i == questionPos &&
        questions[index].answers!.values.toList()[i] == false) {
      return Colors.red[100];
    }
  } else {
    if (i == questionPos && soma != 0) {
      return Colors.indigo[100];
    }
  }

  return Colors.grey[50];
}

Color CorTexto(
    bool btnPressed, int index, int i, bool answer, int questionPos, int soma) {
  if (btnPressed) {
    if (questions[index].answers!.values.toList()[i]) {
      return Colors.green;
    } else if (i == questionPos &&
        questions[index].answers!.values.toList()[i] == false) {
      return Colors.red;
    }
  } else {
    if (i == questionPos && soma != 0) {
      return Colors.indigo;
    }
  }

  return Colors.black;
}

Color? IconCor(
    bool btnPressed, int index, int i, bool answer, int questionPos, int soma) {
  if (btnPressed) {
    if (questions[index].answers!.values.toList()[i]) {
      return Colors.green;
    } else if (i == questionPos &&
        questions[index].answers!.values.toList()[i] == false) {
      return Colors.red;
    }
  } else {
    if (i == questionPos && soma != 0) {
      return Colors.white;
    }
  }

  return Colors.white;
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
    "Carro": true,
    "Bicicleta": false,
    "Moto": false,
    "Aviao": false,
  }),
  QuestionModel("Qual animal é uma ave ?", {
    "Pardal": true,
    "Baleia": false,
    "Gato": false,
    "Cachorro": false,
  }),
  QuestionModel("Quando é 5 * 2 ?", {
    "12": false,
    "33": false,
    "10": true,
    "9": false,
  }),
  QuestionModel("Qual dos animais abaixo é marinho ?", {
    "Pardal": false,
    "Baleia": true,
    "Gato": false,
    "Cachorro": false,
  }),
  QuestionModel("Qual país pertence ao continente europeu ?", {
    "Brasil": false,
    "Espanha": true,
    "Japão": false,
    "Chile": false,
  }),
  QuestionModel("Quais das cores abaixo siginifica vermelho em inglês ?", {
    "Black": false,
    "Green": false,
    "Red": true,
    "Pink": false,
  }),
  QuestionModel(" 8-7 ?", {
    "3": false,
    "1": true,
    "2": false,
    "4": false,
  }),
  QuestionModel("x=2 e y= 5, quanto é x+y ?", {
    "7": true,
    "6": false,
    "8": false,
    "9": false,
  }),
  QuestionModel("Qual animal é um réptil ?", {
    "Aranha": false,
    "Largato": true,
    "Macaco": false,
    "Elefante": false,
  }),
];
