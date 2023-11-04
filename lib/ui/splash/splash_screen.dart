import 'package:flutter/material.dart';

import 'package:ct484_final_project/ui/menu/menu_screen.dart';
import 'package:ct484_final_project/configs/themes/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2e3c62), Color(0xFF99ace1)],
          ),
          image: DecorationImage(
            image: AssetImage('assets/images/app_quiz_logo.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            Center(
              child: Container(
                width: 220,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MenuScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: const BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                  child: Text(
                    'Get started',
                    style: regularTextStyle.copyWith(fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}
