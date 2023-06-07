import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        background: Color.fromARGB(255, 32, 31, 31),
        primary: Color.fromARGB(255, 209, 134, 187),
      ),
    ),
    title: 'BMI calculator',
    debugShowCheckedModeBanner: false,
    home: const HomePage(
      title: 'BMI calculator',
    ),
  ));
}

//strona startowa
class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int weight = 0;
  int height = 0;
  double bmi = 0;
  String bmiValue = 'SET PARAMETERS';
  Widget bmiIcon = const Icon(
    Icons.question_mark,
    color: Color.fromARGB(255, 255, 255, 255),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI calculator'),
      ),
      body: Column(
        //wartosci wybrane przez uzytkownika
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //masa ciala
                  Row(
                    children: [
                      Text(
                        '$weight kg',
                        style: const TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  //wzrost
                  Row(
                    children: [
                      Text(
                        '$height cm',
                        style: const TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ],
              ),
              //przyciski do ustawienia masy i wzrostu
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      //masa ciala
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        onPressed: () async {
                          final userWeight = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const _SetWeight()),
                          );

                          if (userWeight != null) {
                            setState(() {
                              weight = userWeight;
                              bmi = (weight * 10000) / (height * height);
                              if (bmi < 18.5) {
                                bmiValue = 'UNDERWEIGHT';
                                bmiIcon = const Icon(
                                  FontAwesomeIcons.scaleUnbalancedFlip,
                                  color: Color.fromARGB(255, 255, 168, 7),
                                );
                              }
                              if (bmi >= 18.5 && bmi < 25) {
                                bmiValue = 'NORMAL WEIGHT';
                                bmiIcon = const Icon(
                                  FontAwesomeIcons.scaleBalanced,
                                  color: Color.fromARGB(237, 7, 255, 110),
                                );
                              }
                              if (bmi >= 25 && bmi < 30) {
                                bmiValue = 'OVERWEIGHT';
                                bmiIcon = const Icon(
                                  FontAwesomeIcons.scaleUnbalanced,
                                  color: Color.fromARGB(255, 255, 168, 7),
                                );
                              }
                              if (bmi >= 30) {
                                bmiValue = 'OBESITY';
                                bmiIcon = const Icon(
                                  FontAwesomeIcons.scaleUnbalanced,
                                  color: Color.fromARGB(255, 255, 65, 7),
                                );
                              }
                            });
                          }
                        },
                        child: const Text('WEIGHT'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      //wzrost
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        onPressed: () async {
                          final userHeight = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const _SetHeight()),
                          );
                          if (userHeight != null) {
                            setState(() {
                              height = userHeight;
                              bmi = (weight * 10000) / (height * height);
                              if (bmi < 18.5) {
                                bmiValue = 'UNDERWEIGHT';
                                bmiIcon = const Icon(
                                  FontAwesomeIcons.scaleUnbalancedFlip,
                                  color: Color.fromARGB(255, 255, 168, 7),
                                );
                              }
                              if (bmi >= 18.5 && bmi < 25) {
                                bmiValue = 'NORMAL WEIGHT';
                                bmiIcon = const Icon(
                                  FontAwesomeIcons.scaleBalanced,
                                  color: Color.fromARGB(237, 7, 255, 110),
                                );
                              }
                              if (bmi >= 25 && bmi < 30) {
                                bmiValue = 'OVERWEIGHT';
                                bmiIcon = const Icon(
                                  FontAwesomeIcons.scaleUnbalanced,
                                  color: Color.fromARGB(255, 255, 168, 7),
                                );
                              }
                              if (bmi >= 30) {
                                bmiValue = 'OBESITY';
                                bmiIcon = const Icon(
                                  FontAwesomeIcons.scaleUnbalanced,
                                  color: Color.fromARGB(255, 255, 65, 7),
                                );
                              }
                            });
                          }
                        },
                        child: const Text('HEIGHT'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 100),
          //bmi
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Your BMI:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 238, 191, 224),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                bmi.toStringAsFixed(2),
                style: const TextStyle(fontSize: 50),
              ),
            ],
          ),
          const SizedBox(height: 100),
          //czy bmi miesci sie w zakresie
          Container(
            width: 320,
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border:
                  Border.all(color: const Color.fromARGB(255, 235, 219, 219)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bmiIcon,
                const SizedBox(width: 25),
                Text(
                  bmiValue,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SetWeight extends StatefulWidget {
  const _SetWeight({super.key});

  @override
  __SetWeightState createState() => __SetWeightState();
}

//strona do zmiany masy ciala
class __SetWeightState extends State<_SetWeight> {
  int _userWeight = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set weight'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberPicker(
                minValue: 0,
                maxValue: 200,
                axis: Axis.vertical,
                haptics: true,
                value: _userWeight,
                onChanged: (value) => setState(() => _userWeight = value),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: const Color.fromARGB(207, 245, 215, 248)),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _userWeight);
                },
                child: const Text(
                  'Go back!',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SetHeight extends StatefulWidget {
  const _SetHeight({super.key});

  @override
  __SetHeightState createState() => __SetHeightState();
}

//strona do zmiany wzrostu
class __SetHeightState extends State<_SetHeight> {
  int _userHeight = 170;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set height'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberPicker(
                minValue: 50,
                maxValue: 250,
                axis: Axis.vertical,
                haptics: true,
                value: _userHeight,
                onChanged: (value) => setState(() => _userHeight = value),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: const Color.fromARGB(207, 245, 215, 248)),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _userHeight);
                },
                child: const Text(
                  'Go back!',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
