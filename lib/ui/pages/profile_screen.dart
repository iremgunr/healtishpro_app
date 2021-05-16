import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:healtish_app/model/motivation.dart';
import 'package:healtish_app/ui/pages/onboarding_screen.dart';
import 'package:healtish_app/ui/pages/recipeHome_screen.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:intl/intl.dart';
import 'package:healtish_app/services/auth.dart';
import 'package:animations/animations.dart';
import 'calorie_calculator_screen.dart';
import 'package:healtish_app/services/database.dart';

class ProfileScreen extends StatefulWidget {
  final double calorie;

  const ProfileScreen({Key key, this.calorie}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final height = MediaQuery.of(context).size.height;
    final today = DateTime.now();
    Widget getProfile(){
      return Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            height: height * 0.34,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  bottom: const Radius.circular(40)),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 40, left: 32, right: 16, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      trailing: FlatButton.icon(
                        icon: Icon(
                          Icons.logout,
                          color: Color(0xFF200087),
                        ),
                        label: Text(
                          'log out',
                          style: TextStyle(
                            color: Color(0xFF200087),
                          ),
                        ),
                        onPressed: () async {
                          await _auth.signOut();
                        },
                      ),
                      title: Text(
                        "${DateFormat("EEEE").format(today)},${DateFormat(" d MMMM").format(today)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                      subtitle: RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: _auth.getCurrentUser(),
                              style: TextStyle(
                                color: Color(0xFF200087),
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ))
                        ]),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _RadialProgress(
                          calorie: widget.calorie,
                          width: height * 0.15,
                          height: height * 0.14,
                          progress: 0.7,
                        ),
                        _Motivation(
                            motivation: motivations[
                            Random().nextInt(motivations.length - 1)])
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.35,
            left: 0,
            right: 0,

            child: Container(
              height: height * 0.58,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 9,
                      left: 32,
                      right: 16,

                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => RecipeHome()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 65, left: 30, right: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(28)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF20008B),
                              const Color(0XFF200087),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0, left: 8.0),
                                child: Text('Recipes ',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800))),
                            SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                    color: const Color(0xFF5B4D9D),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 51, right: 55),
                                  child: Image.asset(
                                    "assets/meal.png",
                                    width: 250,
                                    height: 65,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => OnboardingScreen()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 60, left: 30, right: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(28)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF20008B),
                              const Color(0XFF200087),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0, left: 8.0),
                                child: Text('Fitness Time! ',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800))),
                            SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                    color: const Color(0xFF5B4D9D),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 51, right: 55),
                                  child: Image.asset(
                                    "assets/ppl.png",
                                    width: 250,
                                    height: 65,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
    List<Widget> pages = [getProfile(),CalorieCalculatorScreen()];
    return Scaffold(
        backgroundColor: const Color(0xFFE9E9E9),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          child: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            iconSize: 40,
            selectedIconTheme: IconThemeData(
              color: const Color(0xFF200087),
            ),
            unselectedIconTheme: IconThemeData(color: Colors.black12),
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  child: Icon(Icons.home),
                  padding: const EdgeInsets.only(top: 8.0),
                ),
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  child: Icon(Icons.settings_applications_rounded),
                  padding: EdgeInsets.only(top: 8.0),
                ),
                title: Text(
                  "Settings",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        body: pages[_currentIndex]);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class _Motivation extends StatelessWidget {
  final Motivation motivation;

  const _Motivation({Key key, @required this.motivation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .55),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              motivation.motivation,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF200087),
                //fontFamily: 'Yatra One',
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _RadialProgress extends StatelessWidget {
  final double height, width, progress, calorie;

  const _RadialProgress(
      {Key key, this.height, this.width, this.progress, this.calorie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadialPainter(progress: 0.7),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$calorie',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: const Color(0XFF200087),
                  ),
                ),
                TextSpan(text: "\n"),
                TextSpan(
                  text: "kcal",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0XFF200087),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RadialPainter extends CustomPainter {
  final double progress;

  _RadialPainter({this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 7
      ..color = Color(0xFF200087)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360 * progress;
    canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: size.width / 2.2,
        ),
        math.radians(-90),
        math.radians(-relativeProgress),
        false,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

