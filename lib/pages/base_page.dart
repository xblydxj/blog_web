import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/config/constants.dart';
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
              CustomPaint(painter: MainBackground(top: 100, radius: 5)),
              topBar(),
//              WhaleLogo(key, size: Size(100.0, 0)),
              child,
            ],
          ),
        )
      ],
    ));
  }

  topBar() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 35, horizontal: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 150,
              child: Text(
                'Sibre.',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: mainColor)),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    child: CupertinoTextField(
                        decoration: BoxDecoration(
                          color: CupertinoDynamicColor.withBrightness(
                            color: CupertinoColors.systemGrey,
                            darkColor: CupertinoColors.systemGrey6,
                          ),
                          border: Border(
                            top: _kDefaultRoundedBorderSide,
                            bottom: _kDefaultRoundedBorderSide,
                            left: _kDefaultRoundedBorderSide,
                            right: _kDefaultRoundedBorderSide,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        placeholder: 'search',
                        placeholderStyle:
                            TextStyle(color: Colors.black26, fontSize: 14),
                        clearButtonMode: OverlayVisibilityMode.editing,
                        readOnly: false,
                        controller: TextEditingController(),
                        focusNode: FocusNode(onKey: (node, event) {
                          //jump search page
                          return false;
                        }),
                        prefixMode: OverlayVisibilityMode.notEditing,
                        prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.search,
                                size: 18, color: CupertinoColors.systemGrey))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('xblydxj',
                            style: TextStyle(
                                fontSize: 15,
                                color: CupertinoColors.systemGrey)),
                      ),
                      CircleAvatar(
                        radius: 18,
                        child: Image.asset(avatar20),
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

const avatar30 = 'assets/avatar/avatar_male_30.png';
const avatar20 = 'assets/avatar/avatar_male_20.png';
const BorderSide _kDefaultRoundedBorderSide = BorderSide(
  color: CupertinoDynamicColor.withBrightness(
    color: Color(0x33000000),
    darkColor: Color(0x33FFFFFF),
  ),
  style: BorderStyle.solid,
  width: 0.0,
);
