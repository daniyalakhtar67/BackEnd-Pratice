// import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart';

import 'package:backend_pratice/login/login_screen.dart';
import 'package:backend_pratice/widgets/splash_services.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  SplashServices splashServices = SplashServices();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.islogin(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: Container(
                    // width: 200,
                    // height: 200,
                    child: Center(child: Image.asset('assets/images/virus.png')),
                  ),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .08),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Backend Pratice',
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}