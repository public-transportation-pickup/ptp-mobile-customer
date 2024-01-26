import 'package:capstone_ptp/pages/main_pages/components/grouped_list_option.dart';
import 'package:capstone_ptp/services/local_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/firebase_authentication.dart';
import 'components/confirm_logout.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuthentication _firebaseAuth = FirebaseAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // BIG STACK
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 357,
                      child: Stack(
                        children: [
                          // Gradient container
                          Container(
                            width: double.infinity,
                            height: 250,
                            decoration: const ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0.00, -1.00),
                                end: Alignment(0, 1),
                                colors: [Color(0xFFFCCF59), Color(0xFFFBAB40)],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 7,
                                  offset: Offset(0, 4),
                                  spreadRadius: -1,
                                )
                              ],
                            ),
                          ),
                          // White container
                          Positioned(
                            top: 120,
                            left: (MediaQuery.of(context).size.width - 367) / 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 367,
                                  height: 224,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                        spreadRadius: -5,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // User avatar
                          Positioned(
                            top: 60,
                            left: (MediaQuery.of(context).size.width - 100) / 2,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  LocalVariables.photoURL ?? '',
                                ),
                              ),
                            ),
                          ),
                          // User name
                          Positioned(
                            top: 170,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        LocalVariables.displayName ?? 'Loading',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color(0xFF353434),
                                          fontSize: 20,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          // User phone
                          Positioned(
                            top: 260,
                            left: (MediaQuery.of(context).size.width - 367) / 2,
                            right:
                                ((MediaQuery.of(context).size.width - 367) / 2),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 110,
                                      child: Text(
                                        'Số điện thoại',
                                        style: TextStyle(
                                          color: Color(0xFF353434),
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    // Value for phone
                                    Expanded(
                                      child: Text(
                                        LocalVariables
                                                    .phoneNumber?.isNotEmpty ==
                                                true
                                            ? LocalVariables.phoneNumber!
                                            : 'Chưa cập nhật',
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          color: Color(0xFF353434),
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // black line
                          Positioned(
                            top: 290,
                            left: (MediaQuery.of(context).size.width - 367) / 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                height: 2,
                                width: 327,
                                color: Colors.black12,
                              ),
                            ),
                          ),
                          // User email
                          Positioned(
                            top: 300,
                            left: (MediaQuery.of(context).size.width - 367) / 2,
                            right:
                                ((MediaQuery.of(context).size.width - 367) / 2),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30), // Adjusted padding
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text "Email"
                                    const SizedBox(
                                      width: 110,
                                      child: Text(
                                        'Email',
                                        style: TextStyle(
                                          color: Color(0xFF353434),
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    // Value for email
                                    Expanded(
                                      child: Text(
                                        LocalVariables
                                                    .currentEmail?.isNotEmpty ==
                                                true
                                            ? LocalVariables.currentEmail!
                                            : 'Chưa cập nhật',
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          color: Color(0xFF353434),
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      //height: MediaQuery.of(context).size.height,
                      height: 680,
                      child: GroupedListOption(),
                    ),
                  ],
                ),
              ],
            ),
            // LOGOUT button
            GestureDetector(
              onTap: () async {
                HapticFeedback.lightImpact();
                bool confirmLogout = await ConfirmLogoutDialog.show(context);

                if (confirmLogout) {
                  //logout firebase
                  await _firebaseAuth.signOut();
                  //clear local variable
                  LocalVariables.authkeyGoogle = '';
                  LocalVariables.displayName = '';
                  LocalVariables.currentEmail = '';
                  LocalVariables.photoURL = '';
                  LocalVariables.uid = '';
                  LocalVariables.jwtToken = '';
                  LocalVariables.phoneNumber = '';
                  // Redirect to the login page and clear the navigation stack
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (Route<dynamic> route) => false,
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.all(16.0),
                width: 367,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Đăng xuất',
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
