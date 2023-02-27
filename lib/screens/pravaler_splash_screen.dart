import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 2000)).then((_) {
      // pushNamedAndRemoveUntil usado para impedir que botão Voltar volte a exibir a Splash
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 99, 91, 1),
      body: Center(
        child: Opacity(
          opacity: _animation.value,
          child: Image.asset('assets/images/pravaler_header.png'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
