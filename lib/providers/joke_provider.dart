import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/joke.dart';

class JokeProvider with ChangeNotifier {
  bool isLoading = false;
  bool isRequestError = false;
  bool isLocationError = false;
  late List<Joke> jokes = [];
  Joke selectedJoke = Joke(q: '', a: '');

  Joke _getRandomJoke() {
    final random = Random();
    return jokes[random.nextInt(jokes.length)];
  }

  void updateJoke() {
    selectedJoke = _getRandomJoke();
    notifyListeners();
  }

  Joke getSelectedJoke() {
    return selectedJoke;
  }

  Future<void> getData({bool isRefresh = false}) async {
    isLoading = true;
    isRequestError = false;
    isLocationError = false;
    if (isRefresh) notifyListeners();

    Uri url = Uri.parse('http://maddadjokes.com/api/data.json');

    try {
      final response = await http.get(url);
      inspect(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData['jokes']
          .forEach((joke) => {jokes.add(Joke(q: joke['q'], a: joke['a']))});
      updateJoke();
      notifyListeners();
    } catch (error) {
      print(error);
      this.isRequestError = true;
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
