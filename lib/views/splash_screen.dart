import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listme/commons/styles.dart';
import 'package:listme/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> animation1;
  double _fontSize = 2;
  double _containerSize = 2;
  double _containerOpacity = 0.0;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    // animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
    //     parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
    //   ..addListener(() {
    //     setState(() {
    //     });
    //   });

    _controller.forward();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _fontSize = 4;
      });
    });

    Timer(const Duration(seconds: 3), () {
      setState(() {
        _containerSize = 1.2;
        _containerOpacity = 1;
      });
    });

    Timer(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
    super.initState();
  }  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: black,
      body: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
            colorFilter: filter,
          ),
        ),
        child: Stack(
          children: [
             AnimatedContainer(
                duration: const Duration(milliseconds: 3000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: _height / _fontSize
              ),
             Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                opacity: _containerOpacity,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _width /_containerSize,
                  width: _width / _containerSize,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      //slogan
                      Text(
                        'Hello Welcome to XXXXXX.',
                        textAlign: TextAlign.center,
                        style: gotu(white, 18.0)
                      ),
                      const SizedBox(height: 10),
                      //sub-slogan
                      Text(
                        'Hope You Like What You See.',
                        textAlign: TextAlign.center,
                        style: gotu(white70, 13.0)
                      ),
                      const Spacer(),
                      
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      
    );
  }
}