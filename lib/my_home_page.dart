import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
   CountDownController _countDownController = CountDownController();
  double percent = 0;
  int _counter = 0;
  static int timeInMinut = 25;
  int timeInSec = timeInMinut * 60;
  late Timer timer;

  void _incrementCounter() {
    setState(() {
      percent;
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  _startTimer() {
    timeInMinut = 25;
    int time = timeInMinut * 60;
    double secPercent = (time / 100);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) {
          time--;
          if (time % 60 == 0) {
            timeInMinut--;
          }
          if (time % secPercent == 0) {
            if (percent < 1) {
              percent += 0.01;
            } else {
              percent = 1;
            }
          } else {
            percent = 0;
            timer.cancel();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.menu,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: badges.Badge(
                    showBadge: true,
                    onTap: () {},
                    badgeContent: Text('3'),
                    badgeAnimation: const badges.BadgeAnimation.rotation(
                      animationDuration: Duration(seconds: 1),
                      //colorChangeAnimationDuration: Duration(seconds: 9),
                      loopAnimation: true,
                      curve: Curves.fastOutSlowIn,
                      //colorChangeAnimationCurve: Curves.easeInCubic,
                    ),
                    badgeStyle: badges.BadgeStyle(elevation: 0),
                    child: Icon(Icons.shopping_cart)))
          ],
          title: Text(widget.title),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffb0d2ff), Color(0xffd8e8ff)],
                  begin: FractionalOffset(0.5, 1))),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

               Expanded(
                  child: CircularCountDownTimer(
                    autoStart: false,
                    controller: _countDownController,
                    duration: 60,
                    width: 150,
                    height:150,
                    textStyle: TextStyle(fontSize: 60),
                    fillColor: Colors.blue,
                    ringColor: Colors.grey,
              )),

              Expanded(
                  child: Container(

                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SingleChildScrollView(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    'Study Timer',
                                    style: TextStyle(fontSize: 25),
                                  ),

                                  Text(
                                    '10',
                                    style: TextStyle(fontSize: 50),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    'Pause Time',
                                    style: TextStyle(fontSize: 25),
                                  ),

                                  Text(
                                    '10',
                                    style: TextStyle(fontSize: 50),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(30),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(shape: CircleBorder(), padding: EdgeInsets.all(8) ),

                              onPressed: () {
                                _countDownController.pause();
                              },
                              child: Icon(Icons.pause_rounded,size: 30,),
                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(shape: CircleBorder(), ),

                              onPressed: () {
                                _countDownController.start();
                              },
                              child: Icon(Icons.arrow_right_rounded,size: 54,),
                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(shape: CircleBorder(), padding: EdgeInsets.all(8) ),

                              onPressed: () {
                                _countDownController.restart();
                              },
                              child: Icon(Icons.restart_alt_rounded,size: 30,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
