import 'package:flutter/material.dart';

class AnimateListTile extends StatefulWidget {
  Widget title;
  Widget expandedTitle;
  Widget list;

  AnimateListTile({this.title, this.expandedTitle, this.list});

  @override
  _AnimateListTileState createState() => _AnimateListTileState();
}

class _AnimateListTileState extends State<AnimateListTile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool isExpanded;
  Animation<EdgeInsetsGeometry> marginAnim;
  Animation<BorderRadius> radiusAnim;
  Animation<double> shadowAnim;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    isExpanded = false;
    marginAnim = Tween(
            begin: EdgeInsets.symmetric(horizontal: 15),
            end: EdgeInsets.symmetric(horizontal: 15))
        .animate(_controller);
    radiusAnim =
        Tween(begin: BorderRadius.circular(0), end: BorderRadius.circular(10))
            .animate(_controller);
    shadowAnim = Tween(begin: 2.0, end: 4.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Container(
              // margin: marginAnim.value,
              decoration: BoxDecoration(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: _onTap,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                      height: 50,
                      decoration: BoxDecoration(color: Colors.white,
                          // borderRadius: radiusAnim.value,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: shadowAnim.value,
                                spreadRadius: shadowAnim.value)
                          ]),
                      child: AnimatedCrossFade(
                        firstChild: widget.title,
                        secondChild: widget.expandedTitle,
                        crossFadeState: isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: Duration(milliseconds: 200),
                      ),
                    ),
                    ClipRect(
                      child:
                          Align(heightFactor: _controller.value, child: child),
                    )
                  ],
                ),
              ),
            ),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: radiusAnim.value,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: shadowAnim.value,
                      spreadRadius: shadowAnim.value)
                ]),
            child: isExpanded || _controller.isDismissed ? widget.list : null));
  }

  _onTap() {
    isExpanded = !isExpanded;
    if (isExpanded) {
      _controller.forward();
      setState(() {});
    } else
      _controller.reverse().then<void>((value) {
        if (mounted) setState(() {});
      });
  }
}
