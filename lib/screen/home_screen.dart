import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<int> timeOptions = [5, 900, 1200, 1500, 1800, 2100];
  int startTime = 1500;
  int breakTime = 300;
  int totalSeconds = 0;
  bool isRunning = false;
  bool isBreaking = false;
  int round = 3;
  int goal = 11;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    totalSeconds = startTime;
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      timer.cancel();
      setState(() {
        if (isBreaking) {
          // 휴식이 끝나면 작업 시간으로 전환하고 타이머 멈춤
          isBreaking = false;
          totalSeconds = startTime;
          isRunning = false;
        } else {
          // 작업이 끝나면 휴식 시간으로 전환하고 자동으로 휴식 타이머 시작
          isBreaking = true;
          totalSeconds = breakTime;
          if (round == 3) {
            round = 0;
            if (goal == 11) {
              goal = 0;
            } else {
              goal += 1;
            }
          } else {
            round += 1;
          }
          // 자동으로 휴식 타이머 시작
          timer = Timer.periodic(Duration(seconds: 1), onTick);
        }
      });
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void onStartPressed() {
    if (!isRunning) {
      if (!isBreaking && totalSeconds == 0) {
        totalSeconds = startTime;
      }
      timer = Timer.periodic(Duration(seconds: 1), onTick);
      setState(() {
        isRunning = true;
      });
    }
  }

  void onPausePressed() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    setState(() {
      totalSeconds = startTime;
      isRunning = false;
      isBreaking = false; // 상태 초기화
    });
  }

  void onTimeSelected(int seconds) {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    setState(() {
      totalSeconds = seconds;
      isRunning = false;
      isBreaking = false; // 상태 초기화
    });
  }

  String format(int seconds) {
    var durtion = Duration(seconds: seconds);
    return durtion.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "POMODORO",
          style: TextStyle(
            color: Theme.of(context).cardColor,
            fontSize: 35,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...timeOptions.map((time) {
                        bool isSelected = time == totalSeconds;
                        return GestureDetector(
                          onTap: () => onTimeSelected(time),
                          child: AnimatedContainer(
                            duration:
                                Duration(milliseconds: 300), // 애니메이션 지속 시간
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).cardColor
                                  : Theme.of(context).scaffoldBackgroundColor,
                              border: Border.all(
                                color: Theme.of(context).cardColor,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "${(time / 60).round()}",
                              style: TextStyle(
                                color: isSelected
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : Theme.of(context).cardColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline),
                  ),
                  if (isRunning) ...[
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: onResetPressed,
                      icon: Icon(Icons.restore_outlined),
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                    ),
                  ],
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ROUND",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .color,
                              ),
                            ),
                            Text(
                              '$round/4',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 90,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "GOAL",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .color,
                              ),
                            ),
                            Text(
                              '$goal/12',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
