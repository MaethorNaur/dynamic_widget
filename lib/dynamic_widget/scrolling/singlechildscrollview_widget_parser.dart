import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';

class SingleChildScrollViewParser extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    var scrollDirection = Axis.vertical;
    if (map.containsKey("scrollDirection") &&
        "horizontal" == map["scrollDirection"]) {
      scrollDirection = Axis.horizontal;
    }

    Map<String, dynamic> childMap = map['child'];
    Widget child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener,
            stateKey: stateKey);

    return SingleChildScrollView(
      child: child,
      scrollDirection: scrollDirection,
    );
  }

  @override
  String get widgetName => 'SingleChildScrollView';
}
