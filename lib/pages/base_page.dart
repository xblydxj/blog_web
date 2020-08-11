import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/widgets/background/background.dart';
import 'package:web/widgets/main_background.dart';
import 'package:web/widgets/whale.dart';

class BasePage extends StatelessWidget {
  const BasePage({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
        body: Stack(
      children: [
        Background(),
        Container(
          margin: EdgeInsets.symmetric(
              vertical: media.size.height / 10,
              horizontal: media.size.width / 8),
          width: media.size.width * 6 / 8,
          height: media.size.height * 8 / 10,
          padding: EdgeInsets.all(3),
          key: key,
          decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 18),
                    blurRadius: 8,
                    spreadRadius: -10)
              ]),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(painter: MainBackground(top: 140, radius: 5)),
//              WhaleLogo(key, size: Size(140.0, 0)),
                  child,
            ],
          ),
        )
      ],
    ));
  }
}
