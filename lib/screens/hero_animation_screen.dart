import 'package:flutter/material.dart';
import '../models/person_class.dart';

class HeroAnimationScreen extends StatelessWidget {
  HeroAnimationScreen({Key? key}) : super(key: key);
  static const String id = 'hero_animation_screen';

  final List<Person> people = [
    Person(name: 'John', age: 20, emoji: '🙋🏻‍'),
    Person(name: 'Jane', age: 21, emoji: '👸🏼'),
    Person(name: 'Jack', age: 22, emoji: '🧑🏾‍🦱'),
  ];

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('People'),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            leading: Hero(
              tag: person.emoji,
              child: Text(person.emoji, style: TextStyle(fontSize: screenHeight * 0.045)),
            ),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            title: Text(person.name),
            subtitle: Text('${person.age} years old'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(person: person)));
            },
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final Person person;
  const DetailsPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: person.emoji,
          flightShuttleBuilder: (flightContext, animation, flightDirection, fromHero, toHero) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                    scale: animation.drive(
                      Tween<double>(begin: 0.0, end: 3.0).chain(CurveTween(curve: Curves.easeInOutQuint)),
                    ),
                    child: fromHero.widget,
                  ),
                );
              case HeroFlightDirection.pop:
                return Material(
                  color: Colors.transparent,
                  child: toHero.widget,
                );
            }
          },
          child: Text(person.emoji, style: TextStyle(fontSize: screenHeight * 0.04)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenHeight * 0.02,
          vertical: screenHeight * 0.03,
        ),
        child: Center(
          child: Column(
            children: [
              Text(person.name, style: TextStyle(fontSize: screenHeight * 0.02)),
              SizedBox(height: screenHeight * 0.018),
              Text('${person.age} years old', style: TextStyle(fontSize: screenHeight * 0.02)),
            ],
          ),
        ),
      ),
    );
  }
}

// flightShuttleBuilder: (flightContext, animation, flightDirection, fromHero, toHero) {
// switch (flightDirection) {
// case HeroFlightDirection.push:
// return Material(
// color: Colors.transparent,
// child: ScaleTransition(
// scale: animation.drive(
// Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeInOutQuint)),
// ),
// child: toHero.widget,
// ),
// );
// case HeroFlightDirection.pop:
// return Material(
// color: Colors.transparent,
// child: fromHero.widget,
// );
// }
// },