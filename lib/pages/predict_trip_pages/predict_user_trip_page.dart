import 'package:flutter/material.dart';

class PredictUserTripPage extends StatefulWidget {
  @override
  _PredictUserTripPageState createState() => _PredictUserTripPageState();
}

class _PredictUserTripPageState extends State<PredictUserTripPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Flutter Homepage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to my Flutter homepage!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
