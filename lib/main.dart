import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String minuteString = "00", secondString = "00", millisecondString = "000";
  int minutes = 0, seconds = 0, milliseconds = 0;
  bool isTimerRunning = false, isResetButtonVisible = false;
  late Timer _timer;

  void startTimer() {
    setState(() {
      isTimerRunning = true;
    });
    _timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      _startMillisecond();
    });
  }

  void pauseTimer() {
    _timer.cancel();
    setState(() {
      isTimerRunning = false;
      isResetButtonVisible = checkValues();
    });
  }

  void _startMillisecond() {
    setState(() {
      if (milliseconds < 999) {
        milliseconds++;
        millisecondString = milliseconds.toString().padLeft(3, '0');
      } else {
        _startSecond();
      }
    });
  }

  void _startSecond() {
    setState(() {
      if (seconds < 59) {
        milliseconds = 0;
        millisecondString = "000";
        seconds++;
        secondString = seconds.toString().padLeft(2, '0');
      } else {
        _startMinute();
      }
    });
  }

  void _startMinute() {
    setState(() {
      milliseconds = 0;
      millisecondString = "000";
      seconds = 0;
      secondString = "00";
      minutes++;
      minuteString = minutes.toString().padLeft(2, '0');
    });
  }

  void resetTimer() {
    _timer.cancel();
    setState(() {
      milliseconds = 0;
      millisecondString = "000";
      seconds = 0;
      secondString = "00";
      minutes = 0;
      minuteString = "00";
      isResetButtonVisible = false;
    });
  }

  bool checkValues() {
    return milliseconds != 0 || seconds != 0 || minutes != 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Text("Stopwatch", style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://thumbs.dreamstime.com/b/stopwatch-grunge-background-classic-chronograph-retro-brown-wallpaper-64035375.jpg'), // Correct path to the image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "STOPWATCH",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$minuteString:$secondString:$millisecondString",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {

                      startTimer();

                    },
                    child: Text(
                      "Start",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Set the background color to blue
                    ),
                  ),
                  SizedBox(width: 15.0),
                  ElevatedButton(
                    onPressed: () {
                      if (isTimerRunning) {
                        pauseTimer();
                      }
                    },
                    child: Text(
                      "Pause",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Set the background color to blue
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              isResetButtonVisible ?
              ElevatedButton(
                onPressed: () {
                  resetTimer();
                },
                child: Text(
                  "Reset",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue),
              )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
