import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  final String title;
  const LoadingCircle({Key? key, this.title = 'Loading'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(title),
          )
        ],
      ),
    );
  }
}
