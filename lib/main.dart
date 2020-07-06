import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown menu animation',
      debugShowCheckedModeBanner: false,
      home: DropdownMenuAnimation(),
    );
  }
}

class DropdownMenuAnimation extends StatefulWidget {
  DropdownMenuAnimation({Key key}) : super(key: key);

  @override
  _DropdownMenuAnimationState createState() => _DropdownMenuAnimationState();
}

class _DropdownMenuAnimationState extends State<DropdownMenuAnimation>
    with TickerProviderStateMixin {
  Color white = Colors.white;
  Color black = Color.fromRGBO(45, 45, 45, 1);
  Size ds = Size(0.0, 0.0);
  double height = 60.0;
  bool isOpen = false;

  AnimationController a;

  Widget icon(IconData icon, bool isOpen) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.0, end: 1.0)
          .animate(CurvedAnimation(curve: Curves.fastOutSlowIn, parent: a)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.center,
        width: 40.0,
        height: isOpen ? 40.0 : 0.0,
        margin: EdgeInsets.only(bottom: 10.0),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    a = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    ds = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      body: GestureDetector(
        onTap: () {
          setState(() {
            if (!isOpen) {
              height = 165.0;
              Timer(Duration(milliseconds: 1000), () {
                a.forward();
              });
            } else {
              a.reverse();
              height = 60.0;
            }
            isOpen = !isOpen;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
          margin: EdgeInsets.only(
              left: ds.width / 2 - 30.0, top: ds.height / 2 - 30.0),
          width: 60.0,
          height: height,
          decoration: BoxDecoration(
            color: black,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              icon(Icons.home, isOpen),
              icon(Icons.add, isOpen),
              icon(Icons.person, isOpen),
            ],
          ),
        ),
      ),
    );
  }
}
