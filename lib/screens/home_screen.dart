import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_screen.dart';
import '../constants.dart';
import 'package:quiz_app/widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: prefer_final_fields
  List<Question> _questions = [
    Question(
      id: '1',
      title: 'What does JVM stand for?',
      options: {
        'Java Virtual Machine': true,
        'Java Visual Model': false,
        'Just Virtual Memory': false,
        'JavaScript Virtual Model': false,
      },
    ),
    Question(
      id: '2',
      title: 'Which keyword is used to define a constant in Java?',
      options: {
        'let': false,
        'static': false,
        'final': true,
        'const': false,
      },
    ),
    Question(
      id: '3',
      title:
          'What is the correct way to declare a method in Java that does not return any value?',
      options: {
        'void method()': true,
        'int method()': false,
        'method void()': false,
        'String method()': false,
      },
    ),
    Question(
      id: '4',
      title:
          'Which data type is used to create a variable that should store text?',
      options: {
        'string': false,
        'Text': false,
        'Char': false,
        'String': true,
      },
    ),
    Question(
      id: '5',
      title: 'In Java, what is the purpose of the "this" keyword?',
      options: {
        'To refer to the current object': true,
        'To create a new instance of a class': false,
        'To invoke a superclass method': false,
        'To initialize an object': false,
      },
    ),
    Question(
      id: '6',
      title: 'Which loop is guaranteed to execute at least once in Java?',
      options: {
        'while loop': false,
        'do-while loop': true,
        'for loop': false,
        'enhanced for loop': false,
      },
    ),
    Question(
      id: '7',
      title: 'What is the correct way to initialize an array in Java?',
      options: {
        'int arr[] = {1, 2, 3};': true,
        'int arr = {1, 2, 3};': false,
        'array arr = [1, 2, 3];': false,
        'int arr() = {1, 2, 3};': false,
      },
    ),
    Question(
      id: '8',
      title:
          'Which access modifier specifies that a method or variable can be accessed by any other class?',
      options: {
        'protected': false,
        'private': false,
        'public': true,
        'default': false,
      },
    ),
    Question(
      id: '9',
      title:
          'What is the process of converting a value from one data type to another called in Java?',
      options: {
        'Type casting': true,
        'Data conversion': false,
        'Variable conversion': false,
        'Value transformation': false,
      },
    ),
    Question(
      id: '10',
      title:
          'Which of these is a mechanism for naming and organizing code into reusable components?',
      options: {
        'Inheritance': false,
        'Polymorphism': false,
        'Abstraction': false,
        'Encapsulation': true,
      },
    ),
  ];

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;
  void nextQuestion() {
    if (index == _questions.length - 1) {
      return;
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('please select any option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
        setState(() {
          isPressed = true;
          isAlreadySelected = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: background,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Questionwidget(
              question: _questions[index].title,
              indexAction: index,
              totalQuestions: _questions.length,
            ),
            const Divider(color: neutral),
            const SizedBox(height: 25.0),
            for (int i = 0; i < _questions[index].options.length; i++)
              GestureDetector(
                onTap: () => checkAnswerAndUpdate(
                    _questions[index].options.values.toList()[i]),
                child: OptionCard(
                  option: _questions[index].options.keys.toList()[i],
                  color: isPressed
                      ? _questions[index].options.values.toList()[i] == true
                          ? correct
                          : incorrect
                      : neutral,
                ),
              )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
