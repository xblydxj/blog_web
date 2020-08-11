import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:web/config/options.dart';

class ModelBinding extends StatefulWidget {
  ModelBinding({
    Key key,
    this.initialModel = const Options(),
    this.child,
  })  : assert(initialModel != null),
        super(key: key);

  final Options initialModel;
  final Widget child;

  @override
  _ModelBindingState createState() => _ModelBindingState();
}

class _ModelBindingState extends State<ModelBinding> {
  Options currentOption;
  Timer _timerDilationTimer;

  @override
  void initState() {
    super.initState();
    currentOption = widget.initialModel;
  }

  @override
  void dispose() {
    _timerDilationTimer?.cancel();
    _timerDilationTimer = null;
    super.dispose();
  }

  void handleTimeDilation(Options newOption) {
    if (currentOption.timeDilation != newOption.timeDilation) {
      _timerDilationTimer?.cancel();
      _timerDilationTimer = null;
      if (newOption.timeDilation > 1) {
        _timerDilationTimer = Timer(const Duration(milliseconds: 150), () {
          timeDilation = newOption.timeDilation;
        });
      } else
        timeDilation = newOption.timeDilation;
    }
  }

  void updateModel(Options newOptions) {
    if (newOptions != currentOption) {
      handleTimeDilation(newOptions);
      setState(() {
        currentOption = newOptions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModelBindingScope(
      modelBindingState: this,
      child: widget.child,
    );
  }
}

class ModelBindingScope extends InheritedWidget {
  ModelBindingScope({
    Key key,
    this.modelBindingState,
    Widget child,
  })  : assert(modelBindingState != null),
        super(key: key, child: child);

  final _ModelBindingState modelBindingState;

  @override
  bool updateShouldNotify(ModelBindingScope oldWidget) => true;
}
