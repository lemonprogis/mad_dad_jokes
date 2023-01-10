import 'package:flutter/material.dart';
import 'package:mad_dad_jokes/providers/joke_provider.dart';
import 'package:provider/provider.dart';

class RequestError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.blue,
            size: 100,
          ),
          SizedBox(height: 10),
          Text(
            'Oh Snap!',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
            child: Text(
              "Refresh and try again...maybe we are busy making more jokes.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            child: Text('Return Home'),
            onPressed: () => Provider.of<JokeProvider>(context, listen: false)
                .getData(isRefresh: true),
          ),
        ],
      ),
    );
  }
}
