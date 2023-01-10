import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:mad_dad_jokes/providers/joke_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/request_error.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<void> _getData() async {
    final jokeProvider = Provider.of<JokeProvider>(context, listen: false);
    jokeProvider.getData();
  }

  _renderFlipCard(ThemeData themeData, JokeProvider jokeProvider) {
    return Card(
      elevation: 0.0,
      margin:
          EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0, bottom: 100.0),
      color: Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 500,
        front: _buildFlipCardSide(
            themeData, jokeProvider.getSelectedJoke().q, 'Tap for answer'),
        back: _buildFlipCardSide(
            themeData, jokeProvider.getSelectedJoke().a, 'Tap for new joke'),
        onFlipDone: (isFront) => {
          if (!isFront) {jokeProvider.updateJoke()}
        },
      ),
    );
  }

  _buildFlipCardSide(ThemeData themeData, String topText, String bottomText) {
    return Container(
      decoration: BoxDecoration(
        color: themeData.secondaryHeaderColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(topText,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center)),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(bottomText,
                  style: Theme.of(context).textTheme.bodyText1)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          backgroundColor: themeContext.backgroundColor,
        ),
        body: SafeArea(
            child: Consumer<JokeProvider>(builder: (context, jokeProvider, _) {
          if (jokeProvider.isRequestError) {
            return RequestError();
          }
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _renderFlipCard(themeContext, jokeProvider),
              ]);
        })));
  }
}
