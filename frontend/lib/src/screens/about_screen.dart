import 'package:flutter/material.dart';
import 'package:web_frontend/src/components/appbar.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(context, index: 4),
      body: Center(
          child: Container(
        alignment: Alignment.center,
        width: MediaQuery.sizeOf(context).width * 0.4,
        child: const Card(
          semanticContainer: true,
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Text(
              'The Egyptian Premier League, also known as the Nile League for sponsorship purposes, after the addition of title sponsor Nile Developments, is a professional association football league in Egypt and the highest division of Egyptian football league system',
              style: TextStyle(
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      )),
    );
  }
}
