import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/widgets/background/background.dart';

class BasePage extends StatelessWidget {
  const BasePage({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
      body:Stack(
        children: [
          Background(),
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: media.size.height / 8,
                  horizontal: media.size.width / 10),
              child: Card(
                key: key,
                color: Colors.white.withOpacity(0.4),
                shadowColor: Colors.white,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Card(
                  key: key,
                  color: Colors.white,
                  margin: EdgeInsets.all(8),
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: child,
                ),
              ))
        ],
      )
    );

  }
}
