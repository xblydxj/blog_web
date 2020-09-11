import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/config/constants.dart';

class TurnBookLoading extends StatefulWidget {
  @override
  _TurnBookLoadingState createState() => _TurnBookLoadingState();
}

class _TurnBookLoadingState extends State<TurnBookLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 7)
      ]),
      height: 88,
      child: Center(
        child: FlipPanel.builder(
            itemsCount: 100,
            itemBuilder: (context, index) => Container(
                  alignment: Alignment.center,
                  width: 72,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      boxShadow: [
                        BoxShadow(
                            color: mainColor.withOpacity(0.3),
                            blurRadius: 1,
                            spreadRadius: 4)
                      ]),
                  child: Container(
                    height: 88,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 0.5,
                              spreadRadius: 0.5)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    child: Column(
                      children: [
                        Expanded(
                            child:
                                Container(color: CupertinoColors.systemGrey3)),
                        SizedBox(height: 6),
                        Expanded(
                            child:
                                Container(color: CupertinoColors.systemGrey3)),
                        SizedBox(height: 6),
                        Expanded(
                            child:
                                Container(color: CupertinoColors.systemGrey3)),
                        SizedBox(height: 6),
                        Expanded(
                            child:
                                Container(color: CupertinoColors.systemGrey3)),
                        SizedBox(height: 6),
                        Expanded(
                            child:
                                Container(color: CupertinoColors.systemGrey3)),
                      ],
                    ),
                  ),
                ),
            period: Duration(milliseconds: 1000)),
      ),
    );
  }
}

typedef Widget IndexedItemBuilder(buildContext, int);

/// Signature for a function that creates a widget for a value emitted from a [Stream]
typedef Widget StreamItemBuilder<T>(buildContext, T);

/// A widget for flip panel with built-in animation
/// Content of the panel is built from [IndexedItemBuilder] or [StreamItemBuilder]
///
/// Note: the content size should be equal
enum FlipDirection { left, right }

class FlipPanel<T> extends StatefulWidget {
  final IndexedItemBuilder indexedItemBuilder;
  final StreamItemBuilder<T> streamItemBuilder;
  final Stream<T> itemStream;
  final int itemsCount;
  final Duration period;
  final Duration duration;
  final int loop;
  final int startIndex;
  final T initValue;
  final double spacing;
  final FlipDirection direction;

  FlipPanel({
    Key key,
    this.indexedItemBuilder,
    this.streamItemBuilder,
    this.itemStream,
    this.itemsCount,
    this.period,
    this.duration,
    this.loop,
    this.startIndex,
    this.initValue,
    this.spacing,
    this.direction,
  }) : super(key: key);

  /// Create a flip panel from iterable source
  /// [itemBuilder] is called periodically in each time of [period]
  /// The animation is looped in [loop] times before finished.
  /// Setting [loop] to -1 makes flip animation run forever.
  /// The [period] should be two times greater than [duration] of flip animation,
  /// if not the animation becomes jerky/stuttery.
  FlipPanel.builder({
    Key key,
    @required IndexedItemBuilder itemBuilder,
    @required this.itemsCount,
    @required this.period,
    this.duration = const Duration(milliseconds: 500),
    this.loop = 1,
    this.startIndex = 0,
    this.spacing = 0.5,
    this.direction = FlipDirection.left,
  })  : assert(itemBuilder != null),
        assert(itemsCount != null),
        assert(startIndex < itemsCount),
        assert(period == null ||
            period.inMilliseconds >= 2 * duration.inMilliseconds),
        indexedItemBuilder = itemBuilder,
        streamItemBuilder = null,
        itemStream = null,
        initValue = null,
        super(key: key);

  /// Create a flip panel from stream source
  /// [itemBuilder] is called whenever a  value is emitted from [itemStream]
  FlipPanel.stream({
    Key key,
    @required this.itemStream,
    @required StreamItemBuilder<T> itemBuilder,
    this.initValue,
    this.duration = const Duration(milliseconds: 500),
    this.spacing = 0.5,
    this.direction = FlipDirection.left,
  })  : assert(itemStream != null),
        indexedItemBuilder = null,
        streamItemBuilder = itemBuilder,
        itemsCount = 0,
        period = null,
        loop = 0,
        startIndex = 0,
        super(key: key);

  @override
  _FlipPanelState<T> createState() => _FlipPanelState<T>();
}

class _FlipPanelState<T> extends State<FlipPanel>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  int _currentIndex;
  bool _isReversePhase;
  bool _isStreamMode;
  bool _running;
  final _perspective = 0.003;
  final _zeroAngle =
      0.0001; // There's something wrong in the perspective transform, I use a very small value instead of zero to temporarily get it around.
  int _loop;
  T _currentValue, _nextValue;
  Timer _timer;
  StreamSubscription<T> _subscription;

  Widget _child1, _child2;
  Widget _leftChild1, _upperChild2;
  Widget _rightChild1, _rightChild2;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.startIndex;
    _isStreamMode = widget.itemStream != null;
    _isReversePhase = false;
    _running = false;
    _loop = 0;

    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isReversePhase = true;
          _controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          _currentValue = _nextValue;
          _running = false;
        }
      })
      ..addListener(() {
        setState(() {
          _running = true;
        });
      });
    _animation = Tween(begin: _zeroAngle, end: pi / 2).animate(_controller);

    if (widget.period != null) {
      _timer = Timer.periodic(widget.period, (_) {
        _child1 = null;
        _isReversePhase = false;
        _controller.forward();
      });
    }

    if (_isStreamMode) {
      _currentValue = widget.initValue;
      _subscription = widget.itemStream.distinct().listen((value) {
        if (_currentValue == null) {
          _currentValue = value;
        } else if (value != _currentValue) {
          _nextValue = value;
          _child1 = null;
          _isReversePhase = false;
          _controller.forward();
        }
      });
    } else if (widget.loop < 0 || _loop < widget.loop) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    if (_subscription != null) _subscription.cancel();
    if (_timer != null) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildChildWidgetsIfNeed(context);

    return _buildPanel();
  }

  void _buildChildWidgetsIfNeed(BuildContext context) {
    Widget makeUpperClip(Widget widget) {
      return ClipRect(
        child: Align(
          alignment: Alignment.centerLeft,
          child: widget,
        ),
      );
    }

    Widget makeLowerClip(Widget widget) {
      return ClipRect(
        child: Align(
          alignment: Alignment.centerRight,
          child: widget,
        ),
      );
    }

    if (_running) {
      if (_child1 == null) {
        _child1 = _child2 != null
            ? _child2
            : _isStreamMode
                ? widget.streamItemBuilder(context, _currentValue)
                : widget.indexedItemBuilder(
                    context, _currentIndex % widget.itemsCount);
        _child2 = null;
        _leftChild1 =
            _upperChild2 != null ? _upperChild2 : makeUpperClip(_child1);
        _rightChild1 =
            _rightChild2 != null ? _rightChild2 : makeLowerClip(_child1);
      }
      if (_child2 == null) {
        _child2 = _isStreamMode
            ? widget.streamItemBuilder(context, _nextValue)
            : widget.indexedItemBuilder(
                context, (_currentIndex + 1) % widget.itemsCount);
        _upperChild2 = makeUpperClip(_child2);
        _rightChild2 = makeLowerClip(_child2);
      }
    } else {
      _child1 = _child2 != null
          ? _child2
          : _isStreamMode
              ? widget.streamItemBuilder(context, _currentValue)
              : widget.indexedItemBuilder(
                  context, _currentIndex % widget.itemsCount);
      _leftChild1 =
          _upperChild2 != null ? _upperChild2 : makeUpperClip(_child1);
      _rightChild1 =
          _rightChild2 != null ? _rightChild2 : makeLowerClip(_child1);
    }
  }

  Widget _buildUpperFlipPanel() => widget.direction == FlipDirection.left
      ? Stack(
          children: [
            Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(2, 3, _perspective)
                  ..rotateY(-_zeroAngle),
                child: _leftChild1),
            Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(2, 3, _perspective)
                ..rotateY(_isReversePhase ? -_animation.value : -pi / 2),
              child: _upperChild2,
            ),
          ],
        )
      : Stack(
          children: [
            Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(2, 3, _perspective)
                  ..rotateY(-_zeroAngle),
                child: _upperChild2),
            Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(2, 3, _perspective)
                ..rotateY(_isReversePhase ? -pi / 2 : -_animation.value),
              child: _leftChild1,
            ),
          ],
        );

  Widget _buildLowerFlipPanel() => widget.direction == FlipDirection.left
      ? Stack(
          children: [
            Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(2, 3, _perspective)
                  ..rotateY(-_zeroAngle),
                child: _rightChild2),
            Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.identity()
                ..setEntry(2, 3, _perspective)
                ..rotateY(_isReversePhase ? -pi / 2 : -_animation.value),
              child: _rightChild1,
            )
          ],
        )
      : Stack(
          children: [
            Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(2, 3, _perspective)
                  ..rotateY(-_zeroAngle),
                child: _rightChild1),
            Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.identity()
                ..setEntry(2, 3, _perspective)
                ..rotateY(_isReversePhase ? -_animation.value : -pi / 2),
              child: _rightChild2,
            )
          ],
        );

  Widget _buildPanel() {
    return _running
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildUpperFlipPanel(),
              Padding(
                padding: EdgeInsets.only(left: widget.spacing),
              ),
              _buildLowerFlipPanel(),
            ],
          )
        : _isStreamMode && _currentValue == null
            ? Container()
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()
                        ..setEntry(2, 3, _perspective)
                        ..rotateY(-_zeroAngle),
                      child: _leftChild1),
                  Padding(
                    padding: EdgeInsets.only(left: widget.spacing),
                  ),
                  Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                      ..setEntry(2, 3, _perspective)
                      ..rotateY(-_zeroAngle),
                    child: _rightChild1,
                  )
                ],
              );
  }
}
