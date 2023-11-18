import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:ct484_final_project/models/quiz.dart';
import 'package:ct484_final_project/utils/app_logger.dart';
import 'package:ct484_final_project/ui/quiz/quiz_card.dart';
import 'package:ct484_final_project/ui/shared/app_drawer.dart';
import 'package:ct484_final_project/configs/themes/theme.dart';
import 'package:ct484_final_project/services/firebase_quiz_service.dart';

class MenuScreen extends StatefulWidget {
  static const routeName = 'menu-screen';

  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late FirebaseQuizService _quizService;

  final TextEditingController _searchController = TextEditingController();

  List<QuizCourse> _allQuizzes = [];
  List<QuizCourse> _filteredQuizzes = [];

  @override
  void initState() {
    super.initState();
    _quizService = FirebaseQuizService();
    _fetchAllQuizzes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchAllQuizzes();
  }

  Future<void> _fetchAllQuizzes() async {
    try {
      final quizzes = await _quizService.fetchAllQuizzes();
      setState(() {
        _allQuizzes = quizzes;
        _filteredQuizzes = quizzes;
      });
    } catch (e) {
      AppLogger.info('Error fetching quizzes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      backgroundColor: airSuperiorityBlue,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        children: [
                          // Avatar
                          ClipOval(
                            child: GestureDetector(
                              onTap: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                              child: Image.asset(
                                'assets/images/icon.png',
                                width: 42,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, Phat',
                                style: boltwhiteTextStyle.copyWith(
                                    fontSize: 18, color: blackColor),
                              ),
                              Text(
                                'Let’s start your quiz now!',
                                style: regularTextStyle.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: softblueColor,
                        border: Border.all(
                          color: const Color(0xff5D5E60),
                          width: 3.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(44.0),
                          bottomLeft: Radius.circular(44.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              "All Quizzes",
                              style: mediaumTextStyle.copyWith(fontSize: 32),
                            ),
                            const SizedBox(height: 15),
                            TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                labelText: 'Search Quizzes',
                                labelStyle: TextStyle(color: lapisLazuli),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: lapisLazuli,
                                    width: 2.0,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7.0)),
                                ),
                                prefixIcon: const Icon(Icons.search),
                              ),
                              onChanged: _handleSearch,
                            ),
                            const SizedBox(height: 20),
                            _buildQuizzesFutureBuilder(),
                            const SizedBox(height: 33),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizzesFutureBuilder() {
    return FutureBuilder<List<QuizCourse>>(
      future: _filterQuizzes(_searchController.text),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader,
				colors: kDefaultRainbowColors,
                strokeWidth: 1,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          AppLogger.info('${snapshot.error}');
          return const Center(child: Text('Something went wrong'));
        } else {
          final quizzes = snapshot.data;
          if (quizzes != null && quizzes.isNotEmpty) {
            return _filteredQuizzes.isNotEmpty
                ? _buildQuizzesListView(_filteredQuizzes)
                : _buildQuizzesListView(quizzes);
          } else {
            return const Center(child: Text('No quizzes found'));
          }
        }
      },
    );
  }

  Future<List<QuizCourse>> _filterQuizzes(String query) async {
    final List<QuizCourse> filteredList = [];
    final List<QuizCourse> allQuizzes = await _quizService.fetchAllQuizzes();

    for (final quiz in allQuizzes) {
      if (quiz.title.toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(quiz);
      }
    }
    return filteredList;
  }

  Widget _buildQuizzesListView(List<QuizCourse> quizzes) {
    return ListView.builder(
      itemCount: quizzes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final quiz = quizzes[index];
        return QuizCard(
          quiz: quiz,
        );
      },
    );
  }

  void _handleSearch(String input) async {
    if (input.isEmpty) {
      setState(() {
        _filteredQuizzes = _allQuizzes;
      });
    } else {
      try {
        setState(() {
          _filteredQuizzes = _allQuizzes.where((quiz) {
            final title = quiz.title.toLowerCase();
            final searchQuery = input.toLowerCase();
            return title.contains(searchQuery);
          }).toList();
        });
      } catch (e) {
        AppLogger.info('Error fetching quizzes: $e');
        setState(() {
          _filteredQuizzes.clear();
        });
      }
    }
  }
}
