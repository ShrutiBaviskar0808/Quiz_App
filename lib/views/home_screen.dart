import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flashcards_quiz/models/flutter_topics_model.dart';
import 'package:flashcards_quiz/views/flashcard_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  _saveThemeMode(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFD030303);
    const Color bgColor3 = Color(0xFF356AEC);
    final theme = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        backgroundColor: Colors.white,  // Set background color to white
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: bgColor3,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.24),
                        blurRadius: 20.0,
                        offset: const Offset(0.0, 10.0),
                        spreadRadius: -10,
                        blurStyle: BlurStyle.outer,
                      )
                    ],
                  ),
                  child: Image.asset("assets/dash.png"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Flutter ",
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        for (var i = 0; i < "Riddles!!!".length; i++) ...[
                          TextSpan(
                            text: "Riddles!!!"[i],
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 21 + i.toDouble(),
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: flutterTopicsList.length,
                  itemBuilder: (context, index) {
                    final topicsData = flutterTopicsList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewCard(
                              typeOfTopic: topicsData.topicQuestions,
                              topicName: topicsData.topicName,
                            ),
                          ),
                        );
                        print(topicsData.topicName);
                      },
                      child: Card(
                        color: bgColor,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                topicsData.topicIcon,
                                color: Colors.white,
                                size: 55,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                topicsData.topicName,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SwitchListTile(
                  title: Text('Dark Mode'),
                  value: _isDarkMode,
                  onChanged: (bool value) {
                    setState(() {
                      _isDarkMode = value;
                    });
                    _saveThemeMode(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
