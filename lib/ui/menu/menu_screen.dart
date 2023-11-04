import 'package:flutter/material.dart';

import 'package:ct484_final_project/widgets/slide.dart';
import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:ct484_final_project/ui/quiz/quiz_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF6F7),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/icon.png',
                          width: 79,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, Jason',
                              style: boltwhiteTextStyle.copyWith(
                                  fontSize: 18, color: blackColor),
                            ),
                            Text(
                              'Let’s start your quiz now !',
                              style: regularTextStyle.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: edge),
                      child: Container(
                        height: 180,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SlideCard(
                              image: 'assets/images/b1.png',
                              level: 'Level 2',
                              name: 'Bahasa',
                            ),
                            SlideCard(
                              image: 'assets/images/b2.png',
                              level: 'Level 2',
                              name: 'Bahasa',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(color: Colors.black, width: 3.0),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(44.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "Recent Quiz",
                              style: mediaumTextStyle.copyWith(fontSize: 18),
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailQuiz()));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(22),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22),
                                    side: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      leading: Image.asset(
                                        'assets/images/planet.png',
                                        width: 65,
                                      ),
                                      title: Text(
                                        'Astronomy',
                                        style: mediaumTextStyle.copyWith(
                                            fontSize: 22),
                                      ),
                                      subtitle:
                                          Text('Learn about the Solar System'),
                                      trailing:
                                          Image.asset('assets/images/Play.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                  side: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    leading:
                                        Image.asset('assets/images/sains.png'),
                                    title: Text(
                                      'Sains',
                                      style: mediaumTextStyle.copyWith(
                                          fontSize: 22),
                                    ),
                                    subtitle: Text(
                                        'Educacao Fisica, Autismo e Inclusao'),
                                    trailing:
                                        Image.asset('assets/images/Play.png'),
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                  side: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    leading:
                                        Image.asset('assets/images/mtk.png'),
                                    title: Text(
                                      'Mathematics',
                                      style: mediaumTextStyle.copyWith(
                                          fontSize: 22),
                                    ),
                                    subtitle: Text(
                                        'Learn fourth grade math—arithmetic,'),
                                    trailing:
                                        Image.asset('assets/images/Play.png'),
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                  side: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    leading: Image.asset(
                                        'assets/images/color-palette.png'),
                                    title: Text(
                                      'Design',
                                      style: mediaumTextStyle.copyWith(
                                          fontSize: 22),
                                    ),
                                    subtitle: Text(
                                        'Learn fourth grade math—arithmetic,'),
                                    trailing:
                                        Image.asset('assets/images/Play.png'),
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                  side: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    leading:
                                        Image.asset('assets/images/medal.png'),
                                    title: Text(
                                      'Olympiade',
                                      style: mediaumTextStyle.copyWith(
                                          fontSize: 22),
                                    ),
                                    subtitle: Text(
                                        'Learn fourth grade math—arithmetic,'),
                                    trailing:
                                        Image.asset('assets/images/Play.png'),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 33),
                          ],
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
    );
  }
}
