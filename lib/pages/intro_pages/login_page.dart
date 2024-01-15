import 'package:flutter/material.dart';
import '../main_pages/page_navigation.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(color: Color(0xFFFFEFC8)),
            ),
          ),
          Positioned(
            left: 29,
            top: 398,
            child: Container(
              width: 340,
              height: 369,
              decoration: ShapeDecoration(
                color: const Color(0xFFFCCF59),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          Positioned(
            left: 78,
            top: 430,
            child: SizedBox(
              width: 184,
              height: 26,
              child: Stack(
                children: [
                  Positioned(
                    left: 105,
                    top: 0,
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Color(0xFFB1B1B1),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        color: Color(0xFF353434),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 87,
                    top: 4,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(1.57),
                      child: Container(
                        width: 22,
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0xFF353434),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: 466,
            child: SizedBox(
              width: 292,
              height: 50,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 292,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(56),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 28,
                    top: 13,
                    child: SizedBox(
                      width: 180,
                      height: 26,
                      child: Text(
                        'Phone number/Email',
                        style: TextStyle(
                          color: Color(0xFFB1B1B1),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: 526,
            child: SizedBox(
              width: 292,
              height: 50,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 292,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(56),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 28,
                    top: 13,
                    child: SizedBox(
                      width: 180,
                      height: 26,
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: Color(0xFFB1B1B1),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 620,
            top: 139,
            child: Container(
              width: 385,
              height: 385,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/385x385"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 670,
            top: 211,
            child: SizedBox(
              width: 204,
              child: Text(
                'Welcome \nto ...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: 691,
            child: SizedBox(
              width: 292,
              height: 45,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 292,
                      height: 45,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(56),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 28,
                    top: 10,
                    child: SizedBox(
                      width: 217,
                      height: 28,
                      child: Stack(
                        children: [
                          const Positioned(
                            left: 40,
                            top: 1,
                            child: SizedBox(
                              width: 177,
                              height: 27,
                              child: Text(
                                'Continue with Google',
                                style: TextStyle(
                                  color: Color(0xFF353434),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 24.52,
                              height: 25,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 130,
            top: 619,
            child: SizedBox(
              width: 133,
              height: 45,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 133,
                      height: 45,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFBAB40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(56),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 23,
                    top: 7,
                    child: SizedBox(
                      width: 86,
                      height: 19,
                      child: Text(
                        'Sign in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFFEFC8),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 78,
            top: 586,
            child: SizedBox(
              width: 280,
              height: 23,
              child: Text(
                'Forgotten password?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
