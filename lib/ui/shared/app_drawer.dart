import 'package:flutter/material.dart';

import 'package:ct484_final_project/utils/app_logger.dart';
import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:ct484_final_project/ui/quiz/user_quiz_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: softpurpleColor,
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2.0),
                    color: whiteColor,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/icon.png',
                      width: 70, // Increase the width to make the image larger
                    ),
                  ),
                ),
                Text(
                  "Ly Phat",
                  style: boltwhiteTextStyle.copyWith(
                    fontSize: 20,
                    color: blackColor,
                  ),
                ),
                Text(
                  "phatb1705292@student.ctu.edu.vn",
                  style: boltwhiteTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.auto_awesome_outlined),
            title: const Text('Explore'),
            onTap: () {
              AppLogger.info('Go to explore page!');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Saved'),
            onTap: () {
              AppLogger.info('Go to saved page!');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () {
              AppLogger.info('Go to history page!');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Quizzes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserQuizScreen()),
              );
              AppLogger.info('Go to management quizzes page!');
            },
          ),
          ListTile(
            leading: const Icon(Icons.query_stats),
            title: const Text('Statistics'),
            onTap: () {

              AppLogger.info('Go to statistics page!');
            },
          ),
          const Expanded(
            child: SizedBox(),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              AppLogger.info('Go to setting page!');
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sign out'),
            onTap: () {
              //   Navigator.of(context)
              //     ..pop()
              //     ..pushReplacementNamed('/');
              //   context.read<AuthManager>().logout();
              AppLogger.info('User logout!');
            },
          ),
        ],
      ),
    );
  }
}
