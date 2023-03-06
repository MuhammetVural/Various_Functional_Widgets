import 'dart:async';
import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;


class Mp3Player extends StatefulWidget {
  const Mp3Player({super.key, });



  @override
  State<Mp3Player> createState() => _Mp3PlayerState();

}

class _Mp3PlayerState extends State<Mp3Player> {

  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.paused;
  String url =   'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';


  Duration position= Duration.zero;
  int duration2 = 0;
  int position2 = 0;

  Widget slider(){
    return Container(
      width: 200,
      child: Slider.adaptive(
        value: (position2/1000).toDouble(),
        max: (duration2/1000).toDouble(),
        onChanged: (value) {
     seekToSec((value.toInt()));
    },),
    );

  }


@override
void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        playerState = state;
      });
    });

    audioPlayer.setSourceUrl(url);
    
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        duration2 = duration.inMilliseconds;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration p) {
setState(() {
  position2 = p.inMilliseconds;
});

    });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
  }

  playMusic(){
  audioPlayer.play(UrlSource(url));

  }
  pauseMusic(){
    audioPlayer.pause();

  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

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
          title: Text('Audio'),
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
              IconButton(onPressed: (){
                playerState == PlayerState.playing ? pauseMusic() : playMusic();
              }, icon: Icon(playerState == PlayerState.playing ? Icons.pause : Icons.play_arrow)),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(duration2.toString()),
                  SizedBox(width: 20,),
                  Container(width: 300,child: slider(),),
                  SizedBox(width: 20,),
                  Text(duration2.toString())
                ],
              )




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

  void seekToSec(int sec) {
    Duration newPosition = Duration(seconds: sec);
    audioPlayer.seek(newPosition);
  }
}
