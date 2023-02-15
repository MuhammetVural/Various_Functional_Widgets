import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Badge(
                label: Text('5'),
                  child: Icon(Icons.shopping_cart))),
          IconButton(
              onPressed: () {},
              icon: badges.Badge(
                  showBadge: true,
                  onTap: () {},
                  badgeContent: Text('3'),
                  badgeAnimation: const badges.BadgeAnimation.rotation(
                    animationDuration: Duration(seconds: 1),
                    //colorChangeAnimationDuration: Duration(seconds: 9),
                    loopAnimation: true ,
                    curve: Curves.fastOutSlowIn,
                    //colorChangeAnimationCurve: Curves.easeInCubic,

                  ),
                  badgeStyle: badges.BadgeStyle(elevation:0),
                  child: Icon(Icons.shopping_cart)))
        ],
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
