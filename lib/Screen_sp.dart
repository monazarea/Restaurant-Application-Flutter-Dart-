import 'dart:async';

import 'package:flutter/material.dart';

import 'log_screen.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with SingleTickerProviderStateMixin
{
  late AnimationController _animationController;
  @override
  void initState(){
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationController.forward();
    Timer(const Duration(seconds: 3),(){

    });
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => loginScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 219, 189),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200,),
            ScaleTransition(
                scale: Tween<double>(begin: 0,end:1).animate(
                  CurvedAnimation(
                    parent:_animationController,
                    curve:Curves.easeOut,
                  ),
                ),
              child: Image.asset('images/cart_logo.png',height: 360,),
            ),
            const SizedBox(
              height: 50,
            ),
            ScaleTransition(
              scale: Tween<double>(begin: 0,end:1).animate(
                CurvedAnimation(
                  parent:_animationController,
                  curve:Curves.linear,
                ),
              ),
              // child: const Text(
              // 'ShopSmart',
              // style: TextStyle(
              //   fontFamily: 'my_fonts',
              //   fontSize: 26,
              //   fontWeight: FontWeight.bold,
              //   color: Colors.black
              //  ),
              // ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SizedBox(
        height: 40,
          child: Text('Powered By Mona Zarea',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic),),
      ),
    );
  }
}
