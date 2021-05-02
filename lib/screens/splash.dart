import 'dart:async';

import 'package:Veegil/screens/auth.dart';
import 'package:Veegil/screens/homepage.dart';
import 'package:Veegil/utils/constants.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int counter = 0;
  Timer _timer;

  void start() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (counter == 5) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          counter++;
        });
      }
    });
  }

  @override
  void initState() {
    start();
    Timer(Duration(milliseconds: 4500), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Auth()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Veegil Bank",
                style: TextStyle(
                    fontSize: width * .07,
                    fontWeight: FontWeight.w700,
                    color: primary)),
            SizedBox(
              height: height * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: width * .03,
                  width: width * .03,
                  decoration: BoxDecoration(
                    border: Border.all(color: primary),
                    shape: BoxShape.circle,
                    color: counter == 1 ? primary : white,
                  ),
                ),
                SizedBox(
                  width: width * .03,
                ),
                Container(
                  height: width * .03,
                  width: width * .03,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: counter == 2 ? primary : white,
                      border: Border.all(color: primary)),
                ),
                SizedBox(
                  width: width * .03,
                ),
                Container(
                  height: width * .03,
                  width: width * .03,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: primary),
                    color: counter == 3 ? primary : white,
                  ),
                ),
                SizedBox(
                  width: width * .03,
                ),
                Container(
                  height: width * .03,
                  width: width * .03,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: primary),
                    color: counter == 4 ? primary : white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
