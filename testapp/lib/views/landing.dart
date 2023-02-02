import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:testapp/views/main_view.dart';
import 'package:testapp/views/sign_in.dart';
import 'package:testapp/views/sign_up.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> with SingleTickerProviderStateMixin {
  late final TabController _controller;
  late final Timer _timer;
  static const _text = [
    'Colors.red',
    'Colors.yellow',
    'Colors.blueAccent',
  ];
  int _index = 0;
  void _circulate() {
    (_index != _text.length - 1) ? _index++ : _index = 0;
    _controller.animateTo(_index);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      initialIndex: _index,
      vsync: this,
    );
    _timer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _circulate(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white10,
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage(
              'assets/background.jpg',
            ),
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [Colors.transparent, Colors.white],
                      stops: [0.0, 0.85])),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Image(
                      image: AssetImage('assets/background.jpg'),
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_text[_controller.index]),
                          const SizedBox(height: 40),
                          TabPageSelector(
                            controller: _controller,
                            color: Colors.black,
                            selectedColor: Colors.purple,
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                    color: Colors.purple,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    onPressed: () => Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const SignIn();
                                        })),
                                    child: Container(
                                      height: 48,
                                      alignment: Alignment.center,
                                      // width: double.infinity,
                                      child: const Text(
                                        'Sign In',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: MaterialButton(
                                    color: Colors.purple,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    onPressed: () => Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const SignUp();
                                        })),
                                    child: Container(
                                      height: 48,
                                      alignment: Alignment.center,
                                      // width: double.infinity,
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Skip',
                                style: const TextStyle(color: Colors.black54),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const MyHomePage();
                                    }));
                                  },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
