import 'dart:async';

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

  _startTimer(){
    timeInMinut = 25;
    int time = timeInMinut *60;
    double secPercent = (time/100);
    timer = Timer.periodic(Duration(seconds: 1),  (timer) {
      setState(() {
        if(time > 0){
          time--;
          if(time % 60 == 0){
            timeInMinut--;
          }
          if(time % secPercent == 0){
            if(percent < 1){
              percent += 0.01;
            }else{
              percent = 1;
            }
          }
          else
          {
            percent =0;
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
                onPressed: () {

                },
                icon:
                    Badge(label: Text('5'), child: Icon(Icons.shopping_cart))),
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
              const Text(
                'Times',
              ),
              Expanded(
                child: CircularPercentIndicator(
                  percent: percent,
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 100,
                  lineWidth: 20,
                  progressColor: Colors.blue,
                  center: Text(
                    '$timeInMinut',
                    style: TextStyle(fontSize: 60, color: Colors.blue),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
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
                          Expanded(
                            child: Column(children: [
                              Text('Study Timer', style: TextStyle(fontSize: 25),),
                              SizedBox(height: 10,),
                              Text('10',style: TextStyle(fontSize: 50),),
                            ],),
                          ),
                          Expanded(
                            child: Column(children: [
                              Text('Pause Time', style: TextStyle(fontSize: 25),),
                              SizedBox(height: 10,),
                              Text('10',style: TextStyle(fontSize: 50),),
                            ],),
                          ),

                        ],
                      ),

                      ),

                      Padding(padding: EdgeInsets.symmetric(vertical: 50),child: ElevatedButton(onPressed: (){
                        _startTimer();
                      }, child: Text('Start'),),),

                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
