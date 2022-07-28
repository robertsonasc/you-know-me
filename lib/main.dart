import 'package:exemplo/button.dart';
import 'package:exemplo/question.dart';
import 'package:exemplo/quiz.dart';
import 'package:exemplo/result.dart';
import 'package:flutter/material.dart';
import 'package:exemplo/questionsAnswerWidget.dart';

main() {
  runApp(const MaterialApp(
    title: 'you know me?',
    home: YouKnowMe(),
  ));
}

/*class YouKnowMe extends StatelessWidget {
  int _cont = 0;

  void _onRespond() {
    _cont++;
    print(_cont);
  }

  @override
  Widget build(BuildContext context) {
    final _questions = ['what is m favorite color?'];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('You know me?')),
        body: Column(
          children: <Widget>[
            Text(_questions[0]),
            RaisedButton(child: Text('Black'), onPressed: _onRespond),
            RaisedButton(child: Text('Blue'), onPressed: _onRespond),
            RaisedButton(child: Text('Red'), onPressed: _onRespond),
          ],
        ),
      ),
    );
  }
}*/

class YouKnowMeState extends State<YouKnowMe> {
  int _cont = 0;
  int _score = 0;
  String appBarTitle = 'you know me?';

  void _onRespond(int score) {
    setState(() {
      _score += score;
      _cont++;
      getAnswerSelected() ? null : appBarTitle = 'finish';
    });
  }

  void restartQuiz() {
    setState(() {
      _cont = 0;
      _score = 0;
      appBarTitle = 'you know me?';
    });
  }

  final List<Map<String, Object>> _questions = [
    {
      'text': 'what is my favorite color?',
      'answers': [
        {'text': 'black', 'score': 1},
        {'text': 'blue', 'score': 0},
        {'text': 'red', 'score': 0},
      ]
    },
    {
      'text': 'what is my favorite musical artist?',
      'answers': [
        {'text': 'Ozzy', 'score': 0},
        {'text': 'Poze do Rodo', 'score': 1},
        {'text': 'Matuê', 'score': 0},
      ]
    },
  ];

  void questionsAnswer(BuildContext context) {}

  bool getAnswerSelected() {
    return _cont < _questions.length;
  }

  @override
  Widget build(BuildContext context) {
    // List<Widget> answersList = [];

    // for (String ans in _questions[_cont].cast()['answers']) {
    //   answersList.add(MyButton(ans, _onRespond));
    // }
    List<Map<String, Object>> answersList;
    getAnswerSelected()
        ? answersList = _questions[_cont].cast()['answers']
        : answersList = [];

    List<Widget> buttonsAnswers = answersList
        .map((resp) => MyButton(resp['text'].toString(),
            () => {_onRespond(int.parse(resp['score'].toString()))}))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: getAnswerSelected()
          ? Quiz(
              Question(_questions[_cont]['text'].toString()),
              buttonsAnswers,
            )
          : Result(
              'ok, you finished the quiz, and got ' +
                  _score.toString() +
                  ' questions right.',
              restartQuiz,
              () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuestionsAnswer(_questions)),
                  )),
    );
  }
}

class YouKnowMe extends StatefulWidget {
  const YouKnowMe({Key? key}) : super(key: key);

  @override
  YouKnowMeState createState() {
    return YouKnowMeState();
  }
}
